import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/authentication/validator.dart';
import '/api/service/test_service.dart';
import '/api/service/submission_service.dart';
import '/api/model/test_model.dart';
import '/api/model/submission_model.dart';
import '/student/student_quiz/display_quizzes.dart';
import '/game/game_home.dart';
import '/timer/countdown_timer.dart';

class TakeQuiz extends StatefulWidget {
  final String quizName;
  TakeQuiz({required this.quizName});

  final User user = FirebaseAuth.instance.currentUser!;

  @override
  State<TakeQuiz> createState() => _TakeQuizState();
}

class _TakeQuizState extends State<TakeQuiz> {
  final _submissionFormKey = GlobalKey<FormState>();

  final _focusAnswer = FocusNode();

  late User _currentUser;

  late String _testName;

  late Future<GetTest>? _futureTest;

  Future<PostSubmission>? _futureSubmission;

  bool _isProcessing = false;
  bool _isSubmitted = false;

  @override
  void initState() {
    _currentUser = widget.user;
    _testName = widget.quizName;
    super.initState();
    _futureTest = TestService().getTest(widget.quizName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusAnswer.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.assignment),
                SizedBox(width: 15),
                Text(
                  "${_testName}",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
          actions: [
            // quiz timer
            if (_isSubmitted == false) 
              CountdownTimer(),
            SizedBox(width: 60),
            // game timer
            CountdownButton(),
            SizedBox(width: 700),
          ]
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<GetTest>(
              future: _futureTest,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final studentName = _currentUser.displayName!;
                  final totalQuestions = (snapshot.data!.data!.questions!).length;
                  List<dynamic> testQuestions = [];
                  for (var i = 0; i < totalQuestions; i++) {
                    testQuestions.add(snapshot.data!.data!.questions![i].description);
                  }
                  List<dynamic> _answerTextController = List.generate(totalQuestions, (i) => TextEditingController());
                  return Form(
                    key: _submissionFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 60),
                        for (var i = 0; i < totalQuestions; i++)
                          Column(
                            children: <Widget>[
                              if (snapshot.data!.data!.questions![i].type == 'multiple-choice') ...[
                                // quiz question
                                Container(
                                  child: Text(
                                    'Question: ${testQuestions[i]}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 15),
                                // question choice
                                Container(
                                  child: Text(
                                    'Choice: ${snapshot.data!.data!.questions![i].options}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 15),
                                // quiz answer input field
                                Container(
                                  width: 600,
                                  child: TextFormField(
                                    controller: _answerTextController[i],
                                    validator: (value) => Validator.validateTextInput(textInput: value),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      labelText: 'Answer',
                                      hintText: "Please Enter Your Answer",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 60),
                              ]
                              else if (snapshot.data!.data!.questions![i].type == 'essay') ...[
                                // quiz question
                                Container(
                                  child: Text(
                                    '${testQuestions[i]}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 30),
                                // quiz answer input field
                                Container(
                                  width: 900,
                                  child: TextFormField(
                                    controller: _answerTextController[i],
                                    validator: (value) => Validator.validateTextInput(textInput: value),
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      labelText: 'Answer',
                                      hintText: "Please Enter Your Answer",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 60),
                              ]
                              else ...[
                                // quiz question
                                Container(
                                  child: Text(
                                    '${testQuestions[i]}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 30),
                                // quiz answer input field
                                Container(
                                  width: 600,
                                  child: TextFormField(
                                    controller: _answerTextController[i],
                                    validator: (value) => Validator.validateTextInput(textInput: value),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      labelText: 'Answer',
                                      hintText: "Please Enter Your Answer",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 60),
                              ]
                            ],
                          ),
                        _isProcessing
                          ? CircularProgressIndicator()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // quiz submit button
                                Padding(
                                  padding: const EdgeInsets.only(top: 90.0),
                                  child: Container(
                                    height: 50,
                                    width: 250,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _focusAnswer.unfocus();
                                        if (_submissionFormKey.currentState!.validate()) {
                                          setState(() {
                                            _isProcessing = true;
                                          });
                                          List<dynamic> textList = _answerTextController.map((x) => x.text).toList();
                                          List<dynamic> submission = [];
                                          for (var i = 0; i < totalQuestions; i++) {
                                            submission.add({'providedAnswer': textList[i]});
                                          }
                                          setState(() {
                                            _futureSubmission = SubmissionService().createSubmission(
                                              studentName,
                                              submission,
                                              _testName,
                                            );
                                            _isSubmitted = true;
                                          });
                                          setState(() {
                                            _isProcessing = false;
                                          });
                                          // pop-up message
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) => submitConfirmation(context),
                                          );
                                        }
                                      },
                                      child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        SizedBox(height: 60),
                      ]
                    ),
                  );
                } else if (snapshot.hasError) {
                  //return Text('${snapshot.error}');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 60),
                      Text(
                        'This Quiz Is No Longer Available.',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ]
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}

// class that return game countdown button
class CountdownButton extends StatefulWidget {
  const CountdownButton({Key? key}) : super(key: key);

  @override
  State<CountdownButton> createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  Timer? _timer2;

  // set maximum time for game
  final _maxSeconds2 = 10;

  int _currentSecond2 = 0;

  bool gameCountdownCompleted = false;
  bool gamePlayed = false;

  // game timer display format
  String get _gameTimerFormat {
    const secondsPerMinute = 60;
    final secondsLeft = _maxSeconds2 - _currentSecond2;

    final formattedMinutesLeft = (secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
    final formattedSecondsLeft = (secondsLeft % secondsPerMinute).toString().padLeft(2, '0');

    if (gameCountdownCompleted) {
      return 'Play!';
    } else {
      return '$formattedMinutesLeft : $formattedSecondsLeft';
    }
  }

  void gameTimer() {
    final duration = Duration(seconds: 1);
    _timer2 = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _currentSecond2 = timer.tick;
        if (timer.tick >= _maxSeconds2) {
          timer.cancel();
          gameCountdownCompleted = true;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer2!.cancel();
  }

  @override
  void initState() {
    super.initState();
    gameTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if ((gameCountdownCompleted) & (gamePlayed == false)) {
            gamePlayed = true;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TRexGameWrapper()),
            );
          }
        },
        child: Text(
          'Game: ${_gameTimerFormat}',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 33, 89, 243),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

// pop-up message after clicked submit button
Widget submitConfirmation(BuildContext context) {
  return AlertDialog(
    title: Text('Submitted!', style: TextStyle(fontSize: 20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Your quiz has been submitted.",
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
    actions: <Widget>[
      // return button
      TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DisplayQuizzes()),
          );
        },
        child: Text(
          'Return to Quiz Page',
          style: TextStyle(
            color: Color.fromARGB(255, 33, 89, 243),
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
