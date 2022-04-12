import 'package:flutter/material.dart';

import '/api/grade_api.dart';
import '/api/models/grade_model.dart';

class ViewGrades extends StatefulWidget {
  const ViewGrades({Key? key}) : super(key: key);

  @override
  State<ViewGrades> createState() => _ViewGradesState();
}

class _ViewGradesState extends State<ViewGrades> {
  late Future<GetGrade_weic4399> _futureGrades;

  Color _gradeColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _futureGrades = GradeAPI().getGrade_weic4399();
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
          child: FutureBuilder<GetGrade_weic4399>(
            future: _futureGrades,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final testGrade = (snapshot.data!.test1!);
                if (testGrade >= 65) {
                  _gradeColor = Colors.green;
                } else if (testGrade < 65) {
                  _gradeColor = Colors.red;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.assignment),
                      SizedBox(width: 5),
                      RichText(
                        text: TextSpan(
                          text: 'Quiz 1 Grade: ',
                          style: TextStyle(fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                              text: '$testGrade',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _gradeColor,
                              )
                            ),
                          ],
                        ),
                      )
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
    );
  }
}
