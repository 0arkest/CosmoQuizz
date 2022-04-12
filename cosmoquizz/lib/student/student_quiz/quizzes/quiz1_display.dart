import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/authentication/validator.dart';
import '/api/test_api.dart';
import '/api/submission_api.dart';
import '/api/models/test_model/test1_model.dart';
import '/api/models/submission_model/test1_submission_model.dart';
import '/student/student_home.dart';

class Quiz1Display extends StatefulWidget {
  Quiz1Display({Key? key}) : super(key: key);
  final User user = FirebaseAuth.instance.currentUser!;

  @override
  State<Quiz1Display> createState() => _Quiz1DisplayState();
}

class _Quiz1DisplayState extends State<Quiz1Display> {
  final _submissonFormKey = GlobalKey<FormState>();

  final _answer1TextController = TextEditingController();
  final _answer2TextController = TextEditingController();

  final _focusAnswer1 = FocusNode();
  final _focusAnswer2 = FocusNode();

  late User _currentUser;

  late Future<GetTest1> _futureTest;

  Future<Test1CreateSubmission>? _futureSubmission;

  bool _isProcessing = false;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
    _futureTest = TestAPI().getTest1();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusAnswer1.unfocus();
        _focusAnswer2.unfocus();
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
                  "Quiz 1",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<GetTest1>(
              future: _futureTest,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final studentName = _currentUser.displayName!;
                  final testName = (snapshot.data!.data!.testName!);
                  final question1 = (snapshot.data!.data!.questions!.dataQuestion1!.description!);
                  final question2 = (snapshot.data!.data!.questions!.dataQuestion2!.description!);
                  List<String> testQuestions = <String> [question1, question2];
                  return Form(
                    key: _submissonFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // quiz question 1
                        Padding(
                          padding: const EdgeInsets.only(top: 150.0),
                          child: Container(
                            child: Text(
                              '${testQuestions[0]}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        // quiz question 1 input field
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _answer1TextController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
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
                        ),
                        // quiz question 2
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Container(
                            child: Text(
                              '${testQuestions[1]}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        // quiz question 2 input field
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _answer2TextController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                        ),
                        _isProcessing
                          ? CircularProgressIndicator()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // submit button
                                Padding(
                                  padding: const EdgeInsets.only(top: 90.0),
                                  child: Container(
                                    height: 50,
                                    width: 250,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _focusAnswer1.unfocus();
                                        _focusAnswer2.unfocus();
                                        if (_submissonFormKey.currentState!.validate()) {
                                          setState(() {
                                            _isProcessing = true;
                                          });
                                          List<dynamic> submission = <dynamic> [
                                            {'providedAnswer': _answer1TextController.text},
                                            {'providedAnswer': _answer2TextController.text},
                                          ];
                                          setState(() {
                                            _futureSubmission = SubmissionAPI().createTest1Submission(
                                              studentName,
                                              submission,
                                              testName,
                                            );
                                          });
                                          setState(() {
                                            _isProcessing = false;
                                          });
                                          // pop-up message
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) => submitSuccess(context),
                                          );
                                        }
                                      },
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
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
                      ]
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

// pop-up message after clicked submit button
Widget submitSuccess(BuildContext context) {
  return AlertDialog(
    title: Text('Submitted Successfully!', style: TextStyle(fontSize: 20)),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentHome()),
          );
        },
        child: Text(
          'Return to Home Page',
          style: TextStyle(
            color: Color.fromARGB(255, 33, 100, 243),
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
