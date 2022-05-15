import 'package:flutter/material.dart';

import '/api/service/test_service.dart';
import '/api/model/test_model.dart';
import './take_quiz.dart';
import '/student/student_home.dart';

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
    return Scaffold(
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
        automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
        actions: [
          // back button
          Center(
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentHome()),
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
                    Text('Choose which quiz to take', style: TextStyle(fontSize: 25)),
                    SizedBox(height: 30),
                    for (var i = 0; i < totalQuizzes; i++)
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
                                  builder: (BuildContext context) => QuizConfirmation(quizName: quizzes[i]),
                                );
                              },
                              child: Text(
                                '${quizzes[i]}',
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
                          SizedBox(height: 60),
                        ],
                      ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
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
class QuizConfirmation extends StatelessWidget {
  final String quizName;

  QuizConfirmation({required this.quizName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Take Quiz?', style: TextStyle(fontSize: 20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Are you sure to take this quiz?",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: <Widget>[
        // yes button
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TakeQuiz(quizName: quizName)),
            );
          },
          child: Text(
            'Yes',
            style: TextStyle(
              color: Color.fromARGB(255, 33, 100, 243),
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
              color: Color.fromARGB(255, 33, 100, 243),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
