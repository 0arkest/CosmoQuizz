import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';

import '/teacher/teacher_home.dart';

class CreateQuiz extends StatefulWidget {
  CreateQuiz({Key? key}) : super(key: key);
  final User user = FirebaseAuth.instance.currentUser!;

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  late User _currentUser;

  PlatformFile? csvFile;

  void chooseFile() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withReadStream: true,
    );
    if (result != null) {
      setState(() {
        csvFile = result.files.single;
      });
    }
  }

  void uploadFile() async {
    final request = http.MultipartRequest('POST', Uri.parse('https://cosmoquizz-api.herokuapp.com/tests/${_currentUser.displayName}'));
    request.files.add(http.MultipartFile("file", csvFile!.readStream!, csvFile!.size, filename: csvFile!.name, contentType: MediaType("text", "csv")));

    var res = await request.send();

    //String result = await res.stream.bytesToString();
    //print(result);
  }

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // set up background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/space_2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.assignment_ind, color: Colors.black),
                  SizedBox(width: 15),
                  Text(
                    "Create Quiz",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                      Text("Back", style: TextStyle(fontSize: 20)),
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 200),
                  ElevatedButton(
                    child: Text(
                      "Choose CSV File to Upload",
                      style: TextStyle(color: Colors.white, fontSize: 25)
                    ),
                    onPressed: () => chooseFile(),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 60, 138, 62),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (csvFile != null) Text("File Name: ${csvFile!.name}", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  if (csvFile != null) Text("File Size: ${csvFile!.size} bytes", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 40),
                  ElevatedButton(
                    child: Text(
                      "Create New Quiz",
                      style: TextStyle(color: Colors.white, fontSize: 25)
                    ),
                    onPressed: () {
                      uploadFile();
                      // pop-up message
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => createConfirmation(context),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 60, 138, 62),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }
}

// pop-up message after clicked create new quiz button
Widget createConfirmation(BuildContext context) {
  return AlertDialog(
    title: Text('Success!', style: TextStyle(fontSize: 20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Your have created a new quiz.",
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
    actions: <Widget>[
      // back button
      TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TeacherHome()),
          );
        },
        child: Text(
          'Back to Home Page',
          style: TextStyle(
            color: Color.fromARGB(255, 60, 138, 62),
            fontSize: 16,
          ),
        ),
      ),
      SizedBox(width: 20),
      // close button
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Close',
          style: TextStyle(
            color: Color.fromARGB(255, 60, 138, 62),
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
