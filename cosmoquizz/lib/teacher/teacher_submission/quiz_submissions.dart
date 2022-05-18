import 'package:flutter/material.dart';

import '/api/service/submission_service.dart';
import '/api/model/submission_model.dart';
import './grade_submission.dart';
import './display_quizzes.dart';

class QuizSubmissions extends StatefulWidget {
  final String quizName;
  const QuizSubmissions({required this.quizName});

  @override
  State<QuizSubmissions> createState() => _QuizSubmissionsState();
}

class _QuizSubmissionsState extends State<QuizSubmissions> {
  late Future<GetSubmissionsOfTest> _futureSubmissions;

  late String _quizName;

  @override
  void initState() {
    _quizName = widget.quizName;
    super.initState();
    _futureSubmissions = SubmissionService().getSubmissionsOfTest(_quizName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // set up background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/space_1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.assignment),
                  SizedBox(width: 15),
                  Text(
                    "All Submissions",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
            actions: [
              // back button
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DisplayQuizzes()),
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
              child: FutureBuilder<GetSubmissionsOfTest>(
                future: _futureSubmissions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final totalSubmissions = (snapshot.data!.data!).length;
                    List<dynamic> submissions = [];
                    for (var i = 0; i < totalSubmissions; i++) {
                      submissions.add(snapshot.data!.data![i].username);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 60),
                        Text(
                          'Choose the Student You Want to Check Submissions:',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        for (var i = 0; i < totalSubmissions; i++)
                          Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 250,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // pop-up message
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => GradeConfirmation(username: submissions[i], quizName: _quizName),
                                    );
                                  },
                                  child: Text(
                                    '${submissions[i]}',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 60),
                            ],
                          ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    //return Text('${snapshot.error}');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 60),
                        Text(
                          'No Submission Found.\n'
                          'Please Check Back Later.',
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
      ]
    );
  }
}

// pop-up message after clicked grade submission button
class GradeConfirmation extends StatelessWidget {
  final String username;
  final String quizName;
  GradeConfirmation({required this.username, required this.quizName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Grade This Submission?',
        style: TextStyle(fontSize: 20)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Confirm to grade submission of this student?",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: <Widget>[
        // continue button
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GradeSubmission(username: username, quizName: quizName)),
            );
          },
          child: Text(
            'Continue',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
            ),
          ),
        ),
        // close button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Back',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
