import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/authentication/auth.dart';
import '/authentication/validator.dart';
import '/api/service/student_service.dart';
import '/api/model/student_model.dart';
import '/main.dart';
import './student_login.dart';
import './student_home.dart';

class StudentSignUp extends StatefulWidget {
  const StudentSignUp({Key? key}) : super(key: key);

  @override
  State<StudentSignUp> createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  final _registerFormKey = GlobalKey<FormState>();

  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _schoolTextController = TextEditingController();
  final _gradeTextController = TextEditingController();
  final _birthdayTextController = TextEditingController();
  final _emergencyContactTextController = TextEditingController();
  
  final _focusUsername = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusFirstName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusSchool = FocusNode();
  final _focusGrade = FocusNode();
  final _focusBirthday = FocusNode();
  final _focusEmergencyContact = FocusNode();

  bool _isProcessing = false;

  Future<PostStudent>? _futureStudent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusUsername.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
        _focusFirstName.unfocus();
        _focusLastName.unfocus();
        _focusSchool.unfocus();
        _focusGrade.unfocus();
        _focusBirthday.unfocus();
        _focusEmergencyContact.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up', style: TextStyle(fontSize: 25)),
          automaticallyImplyLeading: false,   // no default back arrow for going back to the previous page
          actions: [
            // back button
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
                      "Back to Main Page",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromARGB(255, 33, 54, 243),
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // set up logo
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Center(
                      child: Container(
                        width: 500,
                        height: 400,
                        child: Image.asset('logo/CosmoQuizz_transparent.png'),
                      ),
                    ),
                  ),
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // username input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _usernameTextController,
                              focusNode: _focusUsername,
                              validator: (value) => Validator.validateUsername(username: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Username',
                                hintText: "Please Enter Your Username",
                                icon: Icon(
                                  Icons.account_circle,
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
                        SizedBox(height: 15),
                        // email input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(email: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Email',
                                hintText: "Please Enter a Valid Email",
                                icon: Icon(
                                  Icons.mail,
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
                        SizedBox(height: 15),
                        // password input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              validator: (value) => Validator.validatePassword(password: value),
                              obscureText: true,  // hide entered password
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Password',
                                hintText: "Please Enter a Secure Password",
                                icon: Icon(
                                  Icons.lock,
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
                        SizedBox(height: 15),
                        // first name input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _firstNameTextController,
                              focusNode: _focusFirstName,
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'First Name',
                                hintText: "Please Enter Your First Name",
                                icon: Icon(
                                  Icons.person,
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
                        SizedBox(height: 15),
                        // last name input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _lastNameTextController,
                              focusNode: _focusLastName,
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Last Name',
                                hintText: "Please Enter Your Last Name",
                                icon: Icon(
                                  Icons.person,
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
                        SizedBox(height: 15),
                        // school input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _schoolTextController,
                              focusNode: _focusSchool,
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'School',
                                hintText: "Please Enter the Name of Your School",
                                icon: Icon(
                                  Icons.school,
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
                        SizedBox(height: 15),
                        // grade input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _gradeTextController,
                              focusNode: _focusGrade,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Grade',
                                hintText: "Please Enter Your Current Grade",
                                icon: Icon(
                                  Icons.grade,
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
                        SizedBox(height: 15),
                        // birthday input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _birthdayTextController,
                              focusNode: _focusBirthday,
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Birthday',
                                hintText: "Please Enter Your Birthday",
                                icon: Icon(
                                  Icons.date_range,
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
                        SizedBox(height: 15),
                        // phone number input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _emergencyContactTextController,
                              focusNode: _focusEmergencyContact,
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Phone Number',
                                hintText: "Please Enter Your Phone Number",
                                icon: Icon(
                                  Icons.phone,
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
                                // sign up button
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Container(
                                    height: 50,
                                    width: 250,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        _focusUsername.unfocus();
                                        _focusEmail.unfocus();
                                        _focusPassword.unfocus();
                                        _focusFirstName.unfocus();
                                        _focusLastName.unfocus();
                                        _focusSchool.unfocus();
                                        _focusGrade.unfocus();
                                        _focusBirthday.unfocus();
                                        _focusEmergencyContact.unfocus();
                                        if (_registerFormKey.currentState!.validate()) {
                                          setState(() {
                                            _isProcessing = true;
                                          });
                                          User? user = await Authentication.registration(
                                            username: _usernameTextController.text,
                                            email: _emailTextController.text,
                                            password: _passwordTextController.text,
                                          );
                                          setState(() {
                                            _futureStudent = StudentService().createStudent(
                                              _birthdayTextController.text,
                                              _emergencyContactTextController.text,
                                              _firstNameTextController.text,
                                              int.parse(_gradeTextController.text),
                                              _lastNameTextController.text,
                                              _schoolTextController.text,
                                              _usernameTextController.text,
                                              _emailTextController.text,
                                            );
                                          });
                                          setState(() {
                                            _isProcessing = false;
                                          });
                                          if (user != null) {
                                            Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) => StudentHome(),
                                              ),
                                              ModalRoute.withName('/'),
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Register',
                                        style: TextStyle(color: Colors.white, fontSize: 25),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 33, 54, 243),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => StudentLogin()),
                                      );
                                    },
                                    child: Text(
                                      'Already Have an Account? Sign In!',
                                      style: TextStyle(color: Color.fromARGB(255, 33, 100, 243), fontSize: 18),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 60),
                              ],
                            )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
