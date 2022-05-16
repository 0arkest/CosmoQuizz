import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/api/service/grade_service.dart';
import '/api/model/grade_model.dart';

class DisplayGrades extends StatefulWidget {
  DisplayGrades({Key? key}) : super(key: key);
  final User user = FirebaseAuth.instance.currentUser!;

  @override
  State<DisplayGrades> createState() => _DisplayGradesState();
}

class _DisplayGradesState extends State<DisplayGrades> {
  late User _currentUser;

  late Future<GetGrade> _futureGrades;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
    _futureGrades = GradeService().getGrade(_currentUser.displayName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.assignment_turned_in),
              SizedBox(width: 15),
              Text(
                "View Grades",
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
                Navigator.of(context).pop();
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
          child: FutureBuilder<GetGrade>(
            future: _futureGrades,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final testGrades = (snapshot.data!.grades!).length;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 60),
                    for (var i = 0; i < testGrades; i++)
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.assignment),
                              SizedBox(width: 5),
                              RichText(
                                text: TextSpan(
                                  text: '${snapshot.data!.grades![i].testName}: ',
                                  style: TextStyle(fontSize: 20),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${snapshot.data!.grades![i].grade}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ),
                                  ],
                                ),
                              )
                            ]
                          ),
                          SizedBox(height: 60),
                        ],
                      ),
                  ]
                );
              } else if (snapshot.hasError) {
                //return Text('${snapshot.error}');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Text('No Grade Found.'),
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
