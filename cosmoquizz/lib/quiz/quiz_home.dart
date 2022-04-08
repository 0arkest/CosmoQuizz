import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/api/http_service.dart';
import '/api/test_model.dart';
import '/quiz/quiz_grade.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  State<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  late Future<TestModel> futureTest;

  final List<int> submission = [];

  final _submissonFormKey = GlobalKey<FormState>();

  final _answer1TextController = TextEditingController();
  final _answer2TextController = TextEditingController();

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    futureTest = HttpService().getTest();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner: false,  // remove the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<TestModel>(
              future: futureTest,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final question1 = (snapshot.data!.data.questions.dataQuestion1.description);
                  final question2 = (snapshot.data!.data.questions.dataQuestion2.description);
                  List<String> testModels = <String> [question1, question2];
                  int itemCount =  testModels.length;
                  return Form(
                    key: _submissonFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Container(
                            child: Text(
                              '${testModels[0]}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _answer1TextController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                labelText: 'Answer',
                                hintText: "Please Enter Your Answer",
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Container(
                            child: Text(
                              '${testModels[1]}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            width: 600,
                            child: TextFormField(
                              controller: _answer2TextController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                labelText: 'Answer',
                                hintText: "Please Enter Your Answer",
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                        _isProcessing
                          ? CircularProgressIndicator()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 60.0),
                                  child: Container(
                                    height: 50,
                                    width: 250,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_submissonFormKey.currentState!.validate()) {
                                          setState(() {
                                            _isProcessing = true;
                                          });
                                          List<int> submission = <int> [int.parse(_answer1TextController.text), int.parse(_answer2TextController.text)];
                                          setState(() {
                                            _isProcessing = false;
                                          });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => QuizGrade(submission: submission)),
                                          );
                                        }
                                      },
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ]
                          ),
                      ]
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
