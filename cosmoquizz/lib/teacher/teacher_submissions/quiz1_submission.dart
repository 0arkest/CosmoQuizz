import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/authentication/validator.dart';
import '/api/submission_api.dart';
import '/api/models/submission_model/test1_submission_model.dart';
import '/api/grade_api.dart';
import '/api/models/grade_model.dart';
import '/teacher/teacher_home.dart';

class Quiz1_Submission extends StatefulWidget {
  final String studentName;
  const Quiz1_Submission({required this.studentName});

  @override
  State<Quiz1_Submission> createState() => _Quiz1_SubmissionState();
}

class _Quiz1_SubmissionState extends State<Quiz1_Submission> {
  final _gradeFormKey = GlobalKey<FormState>();

  final _gradeTextController = TextEditingController();

  final _focusGrade = FocusNode();

  late String _studentName;

  late Future<GetSubmissions> _futureSubmissions;

  Future<PostGrade>? _futureGrade;

  bool _isProcessing = false;

  @override
  void initState() {
    _studentName = widget.studentName;
    super.initState();
    _futureSubmissions = SubmissionAPI().getSubmissions(_studentName);
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
                  "Quiz 1 Submission",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
          actions: [
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
                  backgroundColor: Color.fromARGB(255, 33, 89, 243),
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
            child: FutureBuilder<GetSubmissions>(
              future: _futureSubmissions,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final quizName = 'test1';

                  final submission = (snapshot.data!.submission0!.item!);

                  final submission_str = submission.toString();

                  List<String> splitQuestion = submission_str.split("dataQuestion2");
                  List<String> splitAnswer = submission_str.split("dataQuestion2");

                  final sub_question1 = splitQuestion[0];
                  final sub_question2 = splitQuestion[1];
                  final sub_answer1 = splitAnswer[0];
                  final sub_answer2 = splitAnswer[1];

                  const ques_start = "description: ";
                  const ques_end = ",";
                  const ans_start = "providedAnswer: ";
                  const ans_end = ",";

                  final q1_startIndex = sub_question1.indexOf(ques_start);
                  final q1_endIndex = sub_question1.indexOf(ques_end, q1_startIndex + ques_start.length);
                  final a1_startIndex = sub_answer1.indexOf(ans_start);
                  final a1_endIndex = sub_answer1.indexOf(ans_end, a1_startIndex + ans_start.length);

                  final q2_startIndex = sub_question2.indexOf(ques_start);
                  final q2_endIndex = sub_question2.indexOf(ques_end, q2_startIndex + ques_start.length);
                  final a2_startIndex = sub_answer2.indexOf(ans_start);
                  final a2_endIndex = sub_answer2.indexOf(ans_end, a2_startIndex + ans_start.length);

                  final question1 = sub_question1.substring(q1_startIndex + ques_start.length, q1_endIndex);
                  final question2 = sub_question2.substring(q2_startIndex + ques_start.length, q2_endIndex);
                  final answer1 = sub_answer1.substring(a1_startIndex + ans_start.length, a1_endIndex);
                  final answer2 = sub_answer2.substring(a2_startIndex + ans_start.length, a2_endIndex);

                  List<dynamic> testQuestions = <dynamic> [question1, question2];
                  List<dynamic> testAnswers = <dynamic> [answer1, answer2];
                  return Form(
                    key: _gradeFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // quiz question 1
                        Padding(
                          padding: const EdgeInsets.only(top: 150.0),
                          child: Container(
                            child: Text(
                              'Question 1: ${testQuestions[0]}\n'
                              'Student Answer: ${testAnswers[0]}\n',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        // quiz question 2
                        Padding(
                          padding: const EdgeInsets.only(top: 150.0, right: 50.0),
                          child: Container(
                            child: Text(
                              'Question 2: ${testQuestions[1]}\n'
                              'Student Answer: ${testAnswers[1]}\n',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        // grade input field
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
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
                                hintText: "Please Enter Grade for This Quiz",
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
                                            _futureGrade = GradeAPI().createGrade(
                                              _studentName,
                                              quizName,
                                              int.parse(_gradeTextController.text),
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
Widget submitSuccess(BuildContext context) {
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
            color: Color.fromARGB(255, 33, 100, 243),
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
