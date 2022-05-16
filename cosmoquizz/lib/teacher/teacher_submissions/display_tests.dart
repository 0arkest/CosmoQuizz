import 'package:flutter/material.dart';

import '/api/service/test_service.dart';
import '/api/model/test_model.dart';
import './display_submissions.dart';
import '/teacher/teacher_home.dart';

class DisplayTests extends StatefulWidget {
  const DisplayTests({Key? key}) : super(key: key);

  @override
  State<DisplayTests> createState() => _DisplayTestsState();
}

class _DisplayTestsState extends State<DisplayTests> {
  late Future<GetAllTests> _futureTest;

  final _themeColor = Color.fromARGB(255, 60, 138, 62);

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
                "All Tests",
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
          child: FutureBuilder<GetAllTests>(
            future: _futureTest,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final tests = snapshot.data!.tests!;
                final totalQests = tests.length;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Text('Choose which test to check submissions', style: TextStyle(fontSize: 25)),
                    SizedBox(height: 30),
                    for (var i = 0; i < totalQests; i++)
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
                                  builder: (BuildContext context) => TestConfirmation(testName: tests[i]),
                                );
                              },
                              child: Text(
                                '${tests[i]}',
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
                    Text('No Test Found.'),
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
class TestConfirmation extends StatelessWidget {
  final String testName;

  TestConfirmation({required this.testName});

  final _themeColor = Color.fromARGB(255, 60, 138, 62);

  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(builder: (context) => DisplaySubmissions(testName: testName)),
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
