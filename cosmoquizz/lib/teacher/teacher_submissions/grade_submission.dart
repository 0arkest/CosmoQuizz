import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/authentication/validator.dart';
import '/api/service/submission_service.dart';
import '/api/model/submission_model.dart';
import '/api/service/grade_service.dart';
import '/api/model/grade_model.dart';
import '/teacher/teacher_home.dart';

class GradeSubmission extends StatefulWidget {
  final String username;
  final String testName;
  const GradeSubmission({required this.username, required this.testName});

  @override
  State<GradeSubmission> createState() => _GradeSubmissionState();
}

class _GradeSubmissionState extends State<GradeSubmission> {
  final _gradeFormKey = GlobalKey<FormState>();

  final _gradeTextController = TextEditingController();

  final _focusGrade = FocusNode();

  final _themeColor = Color.fromARGB(255, 60, 138, 62);

  List<Color> _correctButtonColor = [];
  List<Color> _wrongButtonColor = [];

  late String _username;
  late String _testName;

  List<num> score = [];

  num totalScore = 0;

  late Future<GetSubmission> _futureSubmissions;

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
    _testName = widget.testName;
    super.initState();
    _futureSubmissions = SubmissionService().getSubmission(_username, _testName);
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
                  "Test Submission",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
          actions: [
            // score
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    totalScore = addPoints(score);
                  });
                },
                child: Text(
                  'Auto Calculated Score\n'
                  'Score = ${totalScore.toStringAsFixed(0)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: _themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(width: 60),
            // back button
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeacherHome()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.replay),
                    SizedBox(width: 5),
                    Text(
                      "Back to Home Page",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: _themeColor,
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
              future: _futureSubmissions,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final totalAnswers = (snapshot.data!.data!.submission!).length;
                  for (var i = 0; i < totalAnswers; i++) {
                    score.add(0);
                  }
                  num points = 100/totalAnswers;
                  List<dynamic> questions = [];
                  for (var i = 0; i < totalAnswers; i++) {
                    questions.add(snapshot.data!.data!.submission![i].description);
                  }
                  List<dynamic> correctAnswer = [];
                  for (var i = 0; i < totalAnswers; i++) {
                    correctAnswer.add(snapshot.data!.data!.submission![i].answer);
                  }
                  List<dynamic> submissions = [];
                  for (var i = 0; i < totalAnswers; i++) {
                    submissions.add(snapshot.data!.data!.submission![i].providedAnswer);
                  }
                  for (var i = 0; i < totalAnswers; i++) {
                    _correctButtonColor.add(Colors.grey);
                  }
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
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Container(
                                    child: Text(
                                      'Question: ${questions[i]}',
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                // question choice
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Container(
                                    child: Text(
                                      'Choice: ${snapshot.data!.data!.submission![i].options}\n\n'
                                      'Correct Answer: ${correctAnswer[i]}\n\n'
                                      'Student Answer: ${submissions[i]}',
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox.fromSize(
                                      size: Size(66, 66),
                                      child: ClipOval(
                                        child: Material(
                                          color: _correctButtonColor[i],
                                          child: InkWell(
                                            splashColor: Colors.green,
                                            onTap: () {
                                              score[i] = points;
                                              setState(() {
                                                totalScore = addPoints(score);
                                              });
                                              if (_correctButtonColor[i] == Colors.grey) {
                                                setState(() {
                                                  _correctButtonColor[i] = Colors.green;
                                                  _wrongButtonColor[i] = Colors.grey;
                                                });
                                              } else {
                                                setState(() {
                                                  _correctButtonColor[i] = Colors.grey;
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
                                    SizedBox.fromSize(
                                      size: Size(66, 66),
                                      child: ClipOval(
                                        child: Material(
                                          color: _wrongButtonColor[i],
                                          child: InkWell(
                                            splashColor: Colors.red,
                                            onTap: () {
                                              score[i] = 0;
                                              setState(() {
                                                totalScore = addPoints(score);
                                              });
                                              if (_wrongButtonColor[i] == Colors.grey) {
                                                setState(() {
                                                  _wrongButtonColor[i] = Colors.red;
                                                  _correctButtonColor[i] = Colors.grey;
                                                });
                                              } else {
                                                setState(() {
                                                  _wrongButtonColor[i] = Colors.grey;
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
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Container(
                                    child: Text(
                                      'Question: ${questions[i]}\n\n'
                                      'Correct Answer: ${correctAnswer[i]}\n\n'
                                      'Student Answer: ${submissions[i]}',
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox.fromSize(
                                      size: Size(66, 66),
                                      child: ClipOval(
                                        child: Material(
                                          color: _correctButtonColor[i],
                                          child: InkWell(
                                            splashColor: Colors.green,
                                            onTap: () {
                                              score[i] = points;
                                              setState(() {
                                                totalScore = addPoints(score);
                                              });
                                              if (_correctButtonColor[i] == Colors.grey) {
                                                setState(() {
                                                  _correctButtonColor[i] = Colors.green;
                                                  _wrongButtonColor[i] = Colors.grey;
                                                });
                                              } else {
                                                setState(() {
                                                  _correctButtonColor[i] = Colors.grey;
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
                                    SizedBox.fromSize(
                                      size: Size(66, 66),
                                      child: ClipOval(
                                        child: Material(
                                          color: _wrongButtonColor[i],
                                          child: InkWell(
                                            splashColor: Colors.red,
                                            onTap: () {
                                              score[i] = 0;
                                              setState(() {
                                                totalScore = addPoints(score);
                                              });
                                              if (_wrongButtonColor[i] == Colors.grey) {
                                                setState(() {
                                                  _wrongButtonColor[i] = Colors.red;
                                                  _correctButtonColor[i] = Colors.grey;
                                                });
                                              } else {
                                                setState(() {
                                                  _wrongButtonColor[i] = Colors.grey;
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
                        SizedBox(height: 30),
                        // grade input field
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 600,
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
                                hintText: "Please Enter Grade for This Test",
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
                                // submit grade button
                                Padding(
                                  padding: const EdgeInsets.only(top: 90.0),
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
                                              _testName,
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
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: _themeColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
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

// pop-up message after clicked submit grade button
Widget submitConfirmation(BuildContext context) {
  final _themeColor = Color.fromARGB(255, 60, 138, 62);
  return AlertDialog(
    title: Text('Submitted Successfully!', style: TextStyle(fontSize: 20)),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeacherHome()),
          );
        },
        child: Text(
          'Return to Home Page',
          style: TextStyle(
            color: _themeColor,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
