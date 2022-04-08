import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './firebase_options.dart';
import './portal/login_portal.dart';
import './portal/signup_portal.dart';

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
      debugShowCheckedModeBanner: false,  // remove the debug banner
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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // set up background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/astronomy.jpg"),
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
                color: Colors.blue, borderRadius: BorderRadius.circular(30)
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,   // no back arrow for going back to the previous page
            actions: [
              // sign in button
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPortal()),
                    );
                  },
                  child: Text('Sign In', style: TextStyle(fontSize: 20)),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color.fromARGB(255, 33, 100, 243),
                    padding: const EdgeInsets.all(20)
                  ),
                ),
              ),
              SizedBox(width: 40),
              // sign up button
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPortal()),
                    );
                  },
                  child: Text('Sign Up', style: TextStyle(fontSize: 20)),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color.fromARGB(255, 33, 54, 243),
                    padding: const EdgeInsets.all(20)
                  ),
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
                      child: Image.asset('assets/logo/CosmoQuizz_white.png')
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
              ]
            ),
          ),
        ),
      ]
    );
  }
}
