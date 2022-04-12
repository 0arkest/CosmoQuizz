import 'package:flutter/material.dart';

import '/authentication/validator.dart';
import './quizzes/quiz1_display.dart';

class TakeQuiz extends StatefulWidget {
  const TakeQuiz({Key? key}) : super(key: key);

  @override
  State<TakeQuiz> createState() => _TakeQuizState();
}

class _TakeQuizState extends State<TakeQuiz> {
  final _quizNameFormKey = GlobalKey<FormState>();

  final _quizNameTextController = TextEditingController();

  final _focusquizName = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusquizName.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.assignment),
                SizedBox(width: 15),
                Text(
                  "Take Quiz",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // set up logo
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 90.0),
                  child: Center(
                    child: Container(
                      width: 500,
                      height: 400,
                      child: Image.asset('assets/logo/CosmoQuizz_transparent.png'),
                    ),
                  ),
                ),
                Form(
                  key: _quizNameFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // quiz name input field
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Container(
                          width: 600,
                          child: TextFormField(
                            controller: _quizNameTextController,
                            focusNode: _focusquizName,
                            validator: (value) => Validator.validateTextInput(textInput: value),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              labelText: 'Quiz Name',
                              hintText: 'Enter Quiz Name',
                              icon: Icon(
                                Icons.assignment,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      _isProcessing
                        ? CircularProgressIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // take quiz button
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Container(
                                  height: 50,
                                  width: 250,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _focusquizName.unfocus();
                                      if (_quizNameFormKey.currentState!.validate()) {
                                        setState(() {
                                          _isProcessing = true;
                                        });
                                        if (_quizNameTextController.text == 'test1') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Quiz1Display()),
                                          );
                                        } else {
                                          print("Please enter a valid test name.");
                                        }
                                        setState(() {
                                          _isProcessing = false;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Take Quiz!',
                                      style: TextStyle(color: Colors.white, fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 33, 100, 243),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
