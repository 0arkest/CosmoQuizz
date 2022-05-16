import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import '/teacher/teacher_home.dart';

class CreateTest extends StatefulWidget {
  CreateTest({Key? key}) : super(key: key);
  final User user = FirebaseAuth.instance.currentUser!;

  @override
  _CreateTestState createState() => _CreateTestState();
}

class _CreateTestState extends State<CreateTest> {
  late User _currentUser;

  PlatformFile? objFile;

  Color _themeColor = Color.fromARGB(255, 60, 138, 62);

  void chooseFileUsingFilePicker() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withReadStream: true,
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
      });
    }
  }

  void uploadSelectedFile() async {
    final request = http.MultipartRequest('POST', Uri.parse('https://cosmoquizz-api.herokuapp.com/tests/${_currentUser.displayName}'));
    request.files.add(http.MultipartFile("file", objFile!.readStream!, objFile!.size, filename: objFile!.name, contentType: MediaType("text", "csv")));

    var resp = await request.send();

    String result = await resp.stream.bytesToString();

    print(result);
  }

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
              Icon(Icons.assignment_ind),
              SizedBox(width: 15),
              Text(
                "Create Test",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.green,
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
              SizedBox(height: 60),
              ElevatedButton(
                child: Text("Choose Your CSV File", style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () => chooseFileUsingFilePicker(),
                style: ElevatedButton.styleFrom(
                  primary: _themeColor,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (objFile != null) Text("File name : ${objFile!.name}", style: TextStyle(color: Colors.green, fontSize: 20)),
              SizedBox(height: 10),
              if (objFile != null) Text("File size : ${objFile!.size} bytes", style: TextStyle(color: Colors.green, fontSize: 20)),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text("Create New Test!", style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  uploadSelectedFile();
                  // pop-up message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => submitConfirmation(context),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: _themeColor,
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
    );
  }
}

// pop-up message after clicked submit button
Widget submitConfirmation(BuildContext context) {
  return AlertDialog(
    title: Text('Success!', style: TextStyle(fontSize: 20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Your have create a new quiz.",
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TeacherHome()),
          );
        },
        child: Text(
          'Return Home',
          style: TextStyle(
            color: Color.fromARGB(255, 33, 100, 243),
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
