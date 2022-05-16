import 'package:flutter/material.dart';

import '/api/service/submission_service.dart';
import '/api/model/submission_model.dart';
import './grade_submission.dart';
import '/teacher/teacher_home.dart';

class DisplaySubmissions extends StatefulWidget {
  final String testName;
  const DisplaySubmissions({required this.testName});

  @override
  State<DisplaySubmissions> createState() => _DisplaySubmissionsState();
}

class _DisplaySubmissionsState extends State<DisplaySubmissions> {
  late Future<GetSubmissionsOfTest> _futureSubmissions;

  final _themeColor = Color.fromARGB(255, 60, 138, 62);

  @override
  void initState() {
    super.initState();
    _futureSubmissions = SubmissionService().getSubmissionsOfTest(widget.testName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.green,
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
                    "Back",
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
          child: FutureBuilder<GetSubmissionsOfTest>(
            future: _futureSubmissions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final totalSubmissions = (snapshot.data!.data!).length;
                List<dynamic> submissionUsers = [];
                for (var i = 0; i < totalSubmissions; i++) {
                  submissionUsers.add(snapshot.data!.data![i].username);
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Text('Choose which student to check submissions', style: TextStyle(fontSize: 25)),
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
                                  builder: (BuildContext context) => UserConfirmation(username: submissionUsers[i], testName: widget.testName),
                                );
                              },
                              child: Text(
                                '${submissionUsers[i]}',
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
                    Text('No Submission Found.'),
                  ]
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

// pop-up message after clicked submit button
class UserConfirmation extends StatelessWidget {
  final String username;
  final String testName;

  UserConfirmation({required this.username, required this.testName});

  @override
  Widget build(BuildContext context) {
    final _themeColor = Color.fromARGB(255, 60, 138, 62);
    return AlertDialog(
      title: Text('Check Submissions?', style: TextStyle(fontSize: 20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Are you sure to check submissions of this test?",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: <Widget>[
        // yes button
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GradeSubmission(username: username, testName: testName)),
            );
          },
          child: Text(
            'Yes',
            style: TextStyle(
              color: _themeColor,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Back',
            style: TextStyle(
              color: _themeColor,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
