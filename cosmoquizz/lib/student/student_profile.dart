import 'dart:async';
import 'package:flutter/material.dart';

import '/api/http_service.dart';
import '/api/test_model.dart';

class StudentDisplay extends StatefulWidget {
  const StudentDisplay({Key? key}) : super(key: key);

  @override
  _StudentDisplayState createState() => _StudentDisplayState();
}

class _StudentDisplayState extends State<StudentDisplay> {
  late Future<TestModel> futureTest;

  @override
  void initState() {
    super.initState();
    futureTest = HttpService().getTest();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<TestModel>(
            future: futureTest,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.data.questions.dataQuestion1.description);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
