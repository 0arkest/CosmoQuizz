import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/api/teacher_api.dart';
import '/api/models/teacher_model.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);
  final User user = FirebaseAuth.instance.currentUser!;

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late User _currentUser;

  late Future<GetTeacher> _futureTeacher;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
    _futureTeacher = TeacherAPI().getTeacher(_currentUser.displayName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.assignment_ind),
              SizedBox(width: 15),
              Text(
                "My Profile",
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
        child: FutureBuilder<GetTeacher>(
          future: _futureTeacher,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // set up logo
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, top: 30.0),
                      child: Center(
                        child: Container(
                          width: 500,
                          height: 400,
                          child: Image.asset('assets/logo/CosmoQuizz_transparent.png'),
                        ),
                      ),
                    ),
                    // display username
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.account_circle),
                          SizedBox(width: 5),
                          Text(
                            'Username: ${snapshot.data!.data!.username!}',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    // display email
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.mail),
                          SizedBox(width: 5),
                          Text(
                            'Email: ${snapshot.data!.data!.email!}',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    // display birthday
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.date_range),
                          SizedBox(width: 5),
                          Text(
                            'Birthday: ${snapshot.data!.data!.birthday!}',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    // display first name
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.person),
                          SizedBox(width: 5),
                          Text(
                            'First Name: ${snapshot.data!.data!.firstName!}',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    // display last name
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.person),
                          SizedBox(width: 5),
                          Text(
                            'Last Name: ${snapshot.data!.data!.lastName!}',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    // display school
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.school),
                          SizedBox(width: 5),
                          Text(
                            'School: ${snapshot.data!.data!.school!}',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    // display students
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.grade),
                          SizedBox(width: 5),
                          Text(
                            'Students: ${snapshot.data!.data!.students!}',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
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
    );
  }
}
