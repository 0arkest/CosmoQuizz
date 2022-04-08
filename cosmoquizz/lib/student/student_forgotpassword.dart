import 'package:flutter/material.dart';

import '/authentication/auth.dart';
import '/authentication/validator.dart';
import './student_login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _recoverFormKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();

  final _focusEmail = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Password Recovery", style: TextStyle(fontSize: 25)),
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
                    padding: const EdgeInsets.only(right: 30.0, top: 60.0),
                    child: Center(
                      child: Container(
                        width: 500,
                        height: 400,
                        child: Image.asset('assets/logo/CosmoQuizz_transparent.png')),
                    ),
                  ),
                  Form(
                    key: _recoverFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // email field
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                labelText: 'Email',
                                hintText: "Enter Your Email",
                                icon: Icon(
                                  Icons.mail,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
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
                              // recover password button
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Container(
                                  height: 50,
                                  width: 250,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _focusEmail.unfocus();
                                      if (_recoverFormKey.currentState!.validate()) {
                                        setState(() {
                                          _isProcessing = true;
                                        });
                                        await Authentication.recoverPassword(
                                          email: _emailTextController.text,
                                        );
                                        setState(() {
                                          _isProcessing = false;
                                        });
                                        // pop up window
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) => emailSent(context),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 33, 77, 243),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                    ),
                                    child: Text(
                                      'Recover Password',
                                      style: TextStyle(color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ]
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

Widget emailSent(BuildContext context) {
  return AlertDialog(
    title: Text('Email Sent!', style: TextStyle(fontSize: 20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "An email containing further instructions to recover password has been sent, please check your email.",
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentLogin()),
          );
        },
        child: Text(
          'Return to Login',
          style: TextStyle(color: Color.fromARGB(255, 33, 100, 243), fontSize: 16),
        ),
      ),
      SizedBox(width: 20),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Close',
          style: TextStyle(color: Color.fromARGB(255, 33, 77, 243), fontSize: 16),
        ),
      ),
    ],
  );
}
