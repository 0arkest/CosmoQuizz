import 'package:flutter/material.dart';

import '/api/http_service.dart';

class QuizGrade extends StatefulWidget {
  final List<int> submission;
  const QuizGrade({required this.submission});

  @override
  State<QuizGrade> createState() => _QuizGradeState();
}

class _QuizGradeState extends State<QuizGrade> {
  late List<int> _currentSubmisson;

  @override
  void initState() {
    _currentSubmisson = widget.submission;
    super.initState();
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              child: Text(_currentSubmisson.toString()),
            ),
          ),
        ),
      ),
    );
  }
}
