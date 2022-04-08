import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/authentication/auth.dart';
import '/student/student_login.dart';
import '/student/student_profile.dart';
import '/quiz/quiz_home.dart';

class StudentHome extends StatefulWidget {
  final User user;
  const StudentHome({required this.user});

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  Color buttonColor = Color.fromARGB(255, 33, 89, 243);

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.home),
              SizedBox(width: 15),
              Text("Home", style: TextStyle(fontSize: 25)),
            ],
          ),
        ),
        automaticallyImplyLeading: false,   // no back arrow for going back to the previous page
        actions: [
          Center(
            child: OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.videogame_asset),
                  SizedBox(width: 5),
                  Text(
                    "Game(test)",
                    style: TextStyle(fontSize: 20),
                  )
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
          SizedBox(width: 120),
          // profile button
          Center(
            child: OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.assignment_ind),
                  SizedBox(width: 5),
                  Text(
                    "My Profile",
                    style: TextStyle(fontSize: 20),
                  )
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
          SizedBox(width: 50),
          // quiz button
          Center(
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizHome()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.assignment),
                  SizedBox(width: 5),
                  Text(
                    "Take Quiz",
                    style: TextStyle(fontSize: 20),
                  )
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
          SizedBox(width: 50),
          // grades button
          Center(
            child: OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.assignment_turned_in),
                  SizedBox(width: 5),
                  Text(
                    "My Grades",
                    style: TextStyle(fontSize: 20),
                  )
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
          SizedBox(width: 90),
          // sign out button
          _isSigningOut
            ? CircularProgressIndicator()
            : Center(
                child: OutlinedButton(
                  onPressed: () async {
                    setState(() {
                      _isSigningOut = true;
                    });
                    await FirebaseAuth.instance.signOut();
                    setState(() {
                      _isSigningOut = false;
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => StudentLogin(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 5),
                      Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
          SizedBox(width: 60),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // set up logo
            Padding(
              padding: const EdgeInsets.only(right: 30.0, top: 80.0),
              child: Center(
                child: Container(
                  width: 500,
                  height: 400,
                  child: Image.asset('assets/logo/CosmoQuizz_transparent.png')
                ),
              ),
            ),
            // username display
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.account_circle),
                  SizedBox(width: 5),
                  Text(
                    'Username: ${_currentUser.displayName}',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            // email display
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.mail),
                  SizedBox(width: 5),
                  Text(
                    'Email: ${_currentUser.email}',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            // email verification status
            SizedBox(height: 30),
            _currentUser.emailVerified
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Email Verified',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.sync),
                      onPressed: () async {
                        User? user = await Authentication.refreshUser(_currentUser);
                        if (user != null) {
                          setState(() {
                            _currentUser = user;
                          });
                        }
                      },
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Email Not Verified',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.sync),
                      onPressed: () async {
                        User? user = await Authentication.refreshUser(_currentUser);
                        if (user != null) {
                          setState(() {
                            _currentUser = user;
                          });
                        }
                      },
                    ),
                  ],
                ),
            SizedBox(height: 10),
            _isSendingVerification
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // verify email button
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_currentUser.emailVerified) {
                            print("You have already verified the email.");
                            buttonColor = Colors.grey;
                          }
                          else {
                            setState(() {
                              _isSendingVerification = true;
                            });
                            await _currentUser.sendEmailVerification();
                            setState(() {
                              _isSendingVerification = false;
                            });
                          }
                        },
                        child: Text(
                          'Verify Email',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: buttonColor,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
