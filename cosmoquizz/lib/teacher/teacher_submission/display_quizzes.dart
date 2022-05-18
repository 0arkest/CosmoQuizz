import 'package:flutter/material.dart';

import '/api/service/test_service.dart';
import '/api/model/test_model.dart';
import './quiz_submissions.dart';
import '/teacher/teacher_home.dart';

class DisplayQuizzes extends StatefulWidget {
  const DisplayQuizzes({Key? key}) : super(key: key);

  @override
  State<DisplayQuizzes> createState() => _DisplayQuizzesState();
}

class _DisplayQuizzesState extends State<DisplayQuizzes> {
  late Future<GetAllTests> _futureTest;

  @override
  void initState() {
    super.initState();
    _futureTest = TestService().getAllTests();
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
                    "All Quizzes",
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
                      MaterialPageRoute(builder: (context) => TeacherHome()),
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
              child: FutureBuilder<GetAllTests>(
                future: _futureTest,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final quizzes = snapshot.data!.tests!;
                    final totalQuizzes = quizzes.length;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 60),
                        Text(
                          'Choose the Quiz You Want to Check Submissions:',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        for (var i = 0; i < totalQuizzes; i++)
                          Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 250,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => QuizSubmissions(quizName: quizzes[i])),
                                    );
                                  },
                                  child: Text(
                                    '${quizzes[i]}',
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
                          'No Quiz Found.\n'
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
