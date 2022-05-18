import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/authentication/validator.dart';
import '/api/service/submission_service.dart';
import '/api/model/submission_model.dart';
import '/api/service/grade_service.dart';
import '/api/model/grade_model.dart';
import '/teacher/teacher_submission/quiz_submissions.dart';
import '/teacher/teacher_submission/display_quizzes.dart';

class GradeSubmission extends StatefulWidget {
  final String username;
  final String quizName;
  const GradeSubmission({required this.username, required this.quizName});

  @override
  State<GradeSubmission> createState() => _GradeSubmissionState();
}

class _GradeSubmissionState extends State<GradeSubmission> {
  final _gradeFormKey = GlobalKey<FormState>();

  final _gradeTextController = TextEditingController();

  final _focusGrade = FocusNode();

  List<Color> _correctButtonColor = [];
  List<Color> _wrongButtonColor = [];

  late String _username;
  late String _quizName;

  List<num> _score = [];

  num _totalScore = 0;

  late Future<GetSubmission> _futureSubmission;

  Future<PostGrade>? _futureGrade;

  bool _isProcessing = false;

  num addPoints (List<num> points) {
    num totalPoints = 0;
    for (var i = 0; i < points.length; i++) {
      totalPoints = totalPoints + points[i];
    }
    return totalPoints;
  }

  @override
  void initState() {
    _username = widget.username;
    _quizName = widget.quizName;
    super.initState();
    _futureSubmission = SubmissionService().getSubmission(_username, _quizName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusGrade.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.assignment_turned_in),
                SizedBox(width: 15),
                Text(
                  "Grade Submission",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
          actions: [
            // auto calculated score
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Auto Calculated Score = ',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${_totalScore.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                    ),
                  ],
                ),
              )
            ),
            SizedBox(width: 650),
            // back button
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QuizSubmissions(quizName: _quizName)),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.replay),
                    SizedBox(width: 5),
                    Text("Back", style: TextStyle(fontSize: 20)),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromARGB(255, 60, 138, 62),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(width: 60),
          ]
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<GetSubmission>(
              future: _futureSubmission,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final totalAnswers = (snapshot.data!.data!.submission!).length;
                  for (var i = 0; i < totalAnswers; i++) {
                    _score.add(0);
                  }
                  // set default point for each question
                  num points = 100/totalAnswers;
                  // list of quiz questions
                  List<dynamic> questions = [];
                  for (var i = 0; i < totalAnswers; i++) {
                    questions.add(snapshot.data!.data!.submission![i].description);
                  }
                  // list of quiz correct answers
                  List<dynamic> correctAnswers = [];
                  for (var i = 0; i < totalAnswers; i++) {
                    correctAnswers.add(snapshot.data!.data!.submission![i].answer);
                  }
                  // list of student submitted answers
                  List<dynamic> studentAnswers = [];
                  for (var i = 0; i < totalAnswers; i++) {
                    studentAnswers.add(snapshot.data!.data!.submission![i].providedAnswer);
                  }
                  // set default correct button color
                  for (var i = 0; i < totalAnswers; i++) {
                    _correctButtonColor.add(Colors.grey);
                  }
                  // set default wrong button color
                  for (var i = 0; i < totalAnswers; i++) {
                    _wrongButtonColor.add(Colors.grey);
                  }
                  return Form(
                    key: _gradeFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 60),
                        for (var i = 0; i < totalAnswers; i++)
                          Column(
                            children: <Widget>[
                              if (snapshot.data!.data!.submission![i].type == 'multiple-choice') ...[
                                // quiz question
                                Container(
                                  child: Text(
                                    'Question: ${questions[i]}',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20),
                                // question choice
                                Container(
                                  child: Text(
                                    'Choice: ${snapshot.data!.data!.submission![i].options}\n\n'
                                    'Correct Answer: ${correctAnswers[i]}\n\n'
                                    'Student Answered: ${studentAnswers[i]}',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    // correct button
                                    SizedBox.fromSize(
                                      size: Size(66, 66),
                                      child: ClipOval(
                                        child: Material(
                                          color: _correctButtonColor[i],
                                          child: InkWell(
                                            splashColor: Colors.green,
                                            onTap: () {
                                              if (_correctButtonColor[i] == Colors.grey) {
                                                _score[i] = points;
                                                setState(() {
                                                  _correctButtonColor[i] = Colors.green;
                                                  _wrongButtonColor[i] = Colors.grey;
                                                  _totalScore = addPoints(_score);
                                                });
                                              } else {
                                                _score[i] = 0;
                                                setState(() {
                                                  _correctButtonColor[i] = Colors.grey;
                                                  _totalScore = addPoints(_score);
                                                });
                                              }
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.check),
                                                Text("Correct"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // wrong button
                                    SizedBox.fromSize(
                                      size: Size(66, 66),
                                      child: ClipOval(
                                        child: Material(
                                          color: _wrongButtonColor[i],
                                          child: InkWell(
                                            splashColor: Colors.red,
                                            onTap: () {
                                              if (_wrongButtonColor[i] == Colors.grey) {
                                                _score[i] = 0;
                                                setState(() {
                                                  _wrongButtonColor[i] = Colors.red;
                                                  _correctButtonColor[i] = Colors.grey;
                                                  _totalScore = addPoints(_score);
                                                });
                                              } else {
                                                _score[i] = 0;
                                                setState(() {
                                                  _wrongButtonColor[i] = Colors.grey;
                                                  _totalScore = addPoints(_score);
                                                });
                                              }
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.close),
                                                Text("Wrong"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                                SizedBox(height: 30),
                              ]
                              else ...[
                                // quiz question
                                Container(
                                  child: Text(
                                    'Question: ${questions[i]}\n\n'
                                    'Correct Answer: ${correctAnswers[i]}\n\n'
                                    'Student Answered: ${studentAnswers[i]}',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    // correct button
                                    SizedBox.fromSize(
                                      size: Size(66, 66),
                                      child: ClipOval(
                                        child: Material(
                                          color: _correctButtonColor[i],
                                          child: InkWell(
                                            splashColor: Colors.green,
                                            onTap: () {
                                              if (_correctButtonColor[i] == Colors.grey) {
                                                _score[i] = points;
                                                setState(() {
                                                  _correctButtonColor[i] = Colors.green;
                                                  _wrongButtonColor[i] = Colors.grey;
                                                  _totalScore = addPoints(_score);
                                                });
                                              } else {
                                                _score[i] = 0;
                                                setState(() {
                                                  _correctButtonColor[i] = Colors.grey;
                                                  _totalScore = addPoints(_score);
                                                });
                                              }
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.check),
                                                Text("Correct"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // wrong button
                                    SizedBox.fromSize(
                                      size: Size(66, 66),
                                      child: ClipOval(
                                        child: Material(
                                          color: _wrongButtonColor[i],
                                          child: InkWell(
                                            splashColor: Colors.red,
                                            onTap: () {
                                              if (_wrongButtonColor[i] == Colors.grey) {
                                                _score[i] = 0;
                                                setState(() {
                                                  _wrongButtonColor[i] = Colors.red;
                                                  _correctButtonColor[i] = Colors.grey;
                                                  _totalScore = addPoints(_score);
                                                });
                                              } else {
                                                _score[i] = 0;
                                                setState(() {
                                                  _wrongButtonColor[i] = Colors.grey;
                                                  _totalScore = addPoints(_score);
                                                });
                                              }
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.close),
                                                Text("Wrong"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                                SizedBox(height: 30),
                              ]
                            ],
                          ),
                        // grade input field
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Container(
                            width: 300,
                            child: TextFormField(
                              controller: _gradeTextController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Grade',
                                hintText: "Please Grade This Quiz",
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
                        ),
                        _isProcessing
                          ? CircularProgressIndicator()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // submit button
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Container(
                                    height: 50,
                                    width: 250,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _focusGrade.unfocus();
                                        if (_gradeFormKey.currentState!.validate()) {
                                          setState(() {
                                            _isProcessing = true;
                                          });
                                          setState(() {
                                            _futureGrade = GradeService().createGrade(
                                              _username,
                                              _quizName,
                                              int.parse(_gradeTextController.text),
                                            );
                                          });
                                          setState(() {
                                            _isProcessing = false;
                                          });
                                          // pop-up message
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) => submitConfirmation(context),
                                          );
                                        }
                                      },
                                      child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 60, 138, 62),
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
                      ],
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
                        'This Submission Is No Longer Available',
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

// pop-up message after clicked submit button
Widget submitConfirmation(BuildContext context) {
  return AlertDialog(
    title: Text('Submitted!', style: TextStyle(fontSize: 20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Grade has been submitted.",
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
          'Return to Quizzes Display Page',
          style: TextStyle(
            color: Color.fromARGB(255, 60, 138, 62),
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
