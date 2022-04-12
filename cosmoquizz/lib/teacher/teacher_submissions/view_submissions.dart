import 'package:flutter/material.dart';

import '/authentication/validator.dart';
import './quiz1_submission.dart';

class ViewSubmissions extends StatefulWidget {
  const ViewSubmissions({Key? key}) : super(key: key);

  @override
  State<ViewSubmissions> createState() => _ViewSubmissionsState();
}

class _ViewSubmissionsState extends State<ViewSubmissions> {
  final _studentNameFormKey = GlobalKey<FormState>();

  final _studentNameTextController = TextEditingController();

  final _focusStudentName = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusStudentName.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.assignment_turned_in),
                SizedBox(width: 15),
                Text(
                  "View Submissions",
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
                  key: _studentNameFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // student name input field
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Container(
                          width: 600,
                          child: TextFormField(
                            controller: _studentNameTextController,
                            focusNode: _focusStudentName,
                            validator: (value) => Validator.validateTextInput(textInput: value),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              labelText: 'Student Name',
                              hintText: 'Enter Student Name',
                              icon: Icon(
                                Icons.assignment_turned_in,
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
                              // view submissions button
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Container(
                                  height: 50,
                                  width: 250,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _focusStudentName.unfocus();
                                      if (_studentNameFormKey.currentState!.validate()) {
                                        setState(() {
                                          _isProcessing = true;
                                        });
                                        if (_studentNameTextController.text == 'weic4399') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Quiz1_Submission(studentName: _studentNameTextController.text)),
                                          );
                                        } else {
                                          print("Please enter a valid student name.");
                                        }
                                        setState(() {
                                          _isProcessing = false;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'View Submissions',
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
