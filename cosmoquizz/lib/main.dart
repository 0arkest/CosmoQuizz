import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './firebase_options.dart';
import '/student/student_login.dart';
import '/student/student_signup.dart';
import '/teacher/teacher_login.dart';
import '/teacher/teacher_signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CosmoQuizz());
}

class CosmoQuizz extends StatelessWidget {
  const CosmoQuizz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CosmoQuizz',
      debugShowCheckedModeBanner: false,  // hide debug banner
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? dropdownValue;

  List<DropdownMenuItem<String>> _dropDownLogin() {
    List<String> ddl = ["Student Login", "Teacher Login",];
    return ddl.map(
      (value) =>
      DropdownMenuItem(
        value: value,
        child: Text(value, style: TextStyle(color: Colors.white, fontSize: 20)),
      )
    ).toList();
  }

  List<DropdownMenuItem<String>> _dropDownSignUp() {
    List<String> ddl = ["Student Sign Up", "Teacher Sign Up",];
    return ddl.map(
      (value) =>
      DropdownMenuItem(
        value: value,
        child: Text(value, style: TextStyle(color: Colors.white, fontSize: 20)),
      )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // set up background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/astronomy.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Container(
              width: 150,
              height: 50,
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("Main", style: TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
            actions: [
              // sign in buttons
              Container(
                margin: const EdgeInsets.all(3.0),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  value: dropdownValue,
                  items: _dropDownLogin(),
                  onChanged: (String? value){
                    dropdownValue = value;
                    switch(value){
                      case "Student Login" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudentLogin()),
                        );
                        break;
                      case "Teacher Login" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherLogin()),
                        );
                        break;
                    }
                  },
                  hint: Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 20)),
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: Colors.lightBlue,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(width: 50),
              Container(
                margin: const EdgeInsets.all(3.0),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  value: dropdownValue,
                  items: _dropDownSignUp(),
                  onChanged: (String? value){
                    dropdownValue = value;
                    switch(value){
                      case "Student Sign Up" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudentSignUp()),
                        );
                        break;
                      case "Teacher Sign Up" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherSignUp()),
                        );
                        break;
                    }
                  },
                  hint: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 20)),
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: Colors.blueAccent,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(width: 100),
            ]
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // set up logo
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 150.0),
                  child: Center(
                    child: Container(
                      width: 500,
                      height: 400,
                      child: Image.asset('assets/logo/CosmoQuizz_white.png'),
                    ),
                  ),
                ),
                // set up description
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    'CosmoQuizz is an app that will help kids manage their workload by allowing game breaks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(6.0, 6.0),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                /*
                SizedBox(height: 30),
                // use to test stuffs without login
                Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text(
                      'test',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                */
              ]
            ),
          ),
        ),
      ]
    );
  }
}
