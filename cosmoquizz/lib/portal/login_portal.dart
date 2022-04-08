import 'package:flutter/material.dart';

import '/main.dart';
import '/student/student_login.dart';
import '/portal/signup_portal.dart';

class LoginPortal extends StatefulWidget {
  const LoginPortal({Key? key}) : super(key: key);

  @override
  State<LoginPortal> createState() => _LoginPortalState();
}

class _LoginPortalState extends State<LoginPortal> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // set up background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/space.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Container(
              width: 250,
              height: 50,
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("Sign In Portal", style: TextStyle(color: Colors.white, fontSize: 25)),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 33, 100, 243), borderRadius: BorderRadius.circular(30)
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,   // no back arrow for going back to the previous page
            actions: [
              // return button
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.replay),
                      SizedBox(width: 5),
                      Text(
                        "Return to Main Page",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    primary: Colors.white,
                    backgroundColor: Color.fromARGB(255, 33, 100, 243),
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
                      child: Image.asset('assets/logo/CosmoQuizz_white.png')
                    ),
                  ),
                ),
                // student sign in button
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 33, 100, 243),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudentLogin()),
                        );
                      },
                      child: Text(
                        'Log In as Student',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // teacher sign in button
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 33, 100, 243),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Log In as Teacher',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Text(
                    'Or,',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPortal()),
                      );
                    },
                    child: Text(
                      'Switch to Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ]
    );
  }
}
