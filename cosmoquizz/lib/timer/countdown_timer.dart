import 'dart:async';
import 'package:flutter/material.dart';

import '/student/student_quiz/display_quizzes.dart';

// class that return countdown timer for quiz
class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;

  // set maximum time for quiz
  final _maxSeconds = 60;

  int _currentSecond = 0;

  // time display format
  String get _timerFormat {
    const secondsPerMinute = 60;
    final secondsLeft = _maxSeconds - _currentSecond;

    final formattedMinutesLeft = (secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
    final formattedSecondsLeft = (secondsLeft % secondsPerMinute).toString().padLeft(2, '0');

    // return minutes:seconds
    return '$formattedMinutesLeft:$formattedSecondsLeft';
  }

  void quizTimer() {
    final duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _currentSecond = timer.tick;
        // if time has passed
        if (timer.tick >= _maxSeconds) {
          timer.cancel();
          // pop-up message
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => quizTimeout(context),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    quizTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer),
          SizedBox(width: 5),
          Text(
            'Time Left: ${_timerFormat}',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

// pop-up message when timeout
Widget quizTimeout(BuildContext context) {
  return AlertDialog(
    title: Text(
      'Time Out!',
      style: TextStyle(
        fontSize: 20,
        color: Colors.red,
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Time has passed for you to submit the quiz.",
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
    actions: <Widget>[
      // return button
      TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DisplayQuizzes()),
          );
        },
        child: Text(
          'Return to Quizzes Display Page',
          style: TextStyle(
            color: Color.fromARGB(255, 33, 89, 243),
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
