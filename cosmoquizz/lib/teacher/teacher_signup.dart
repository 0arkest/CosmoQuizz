import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/authentication/auth.dart';
import '/authentication/validator.dart';
import '/api/service/teacher_service.dart';
import '/api/model/teacher_model.dart';
import '/main.dart';
import './teacher_login.dart';
import './teacher_home.dart';

class TeacherSignUp extends StatefulWidget {
  const TeacherSignUp({Key? key}) : super(key: key);

  @override
  State<TeacherSignUp> createState() => _TeacherSignUpState();
}

class _TeacherSignUpState extends State<TeacherSignUp> {
  final _registerFormKey = GlobalKey<FormState>();

  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _schoolTextController = TextEditingController();
  final _subjectTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _birthdayTextController = TextEditingController();
  final _bioTextController = TextEditingController();
  
  final _focusUsername = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusFirstName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusSchool = FocusNode();
  final _focusSubject = FocusNode();
  final _focusPhone = FocusNode();
  final _focusBirthday = FocusNode();
  final _focusBio = FocusNode();

  bool _isProcessing = false;

  Future<PostTeacher>? _futureTeacher;

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
        _focusSubject.unfocus();
        _focusPhone.unfocus();
        _focusBirthday.unfocus();
        _focusBio.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up as Teacher', style: TextStyle(fontSize: 25)),
          backgroundColor: Colors.green,
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
                  backgroundColor: Color.fromARGB(255, 60, 138, 62),
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
                        child: Image.asset('assets/logo/CosmoQuizz_transparent.png'),
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
                                hintText: "Please Enter Your School Name",
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
                        // subject input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _subjectTextController,
                              focusNode: _focusSubject,
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Subject',
                                hintText: "Please Enter Your Subject",
                                icon: Icon(
                                  Icons.book,
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
                              controller: _phoneTextController,
                              focusNode: _focusPhone,
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
                        // biography input field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _bioTextController,
                              focusNode: _focusBio,
                              validator: (value) => Validator.validateTextInput(textInput: value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: 'Biography',
                                hintText: "Please Enter Your Biography",
                                icon: Icon(
                                  Icons.subject,
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
                                        _focusSubject.unfocus();
                                        _focusPhone.unfocus();
                                        _focusBirthday.unfocus();
                                        _focusBio.unfocus();
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
                                            _futureTeacher = TeacherService().createTeacher(
                                              _bioTextController.text,
                                              _birthdayTextController.text,
                                              _firstNameTextController.text,
                                              _lastNameTextController.text,
                                              _phoneTextController.text,
                                              _subjectTextController.text,
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
                                                builder: (context) => TeacherHome(),
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
                                        primary: Color.fromARGB(255, 60, 138, 62),
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
                                        MaterialPageRoute(builder: (context) => TeacherLogin()),
                                      );
                                    },
                                    child: Text(
                                      'Already Have an Account? Sign In!',
                                      style: TextStyle(color: Color.fromARGB(255, 60, 138, 62), fontSize: 18),
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
