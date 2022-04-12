import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import './models/submission_model/test1_submission_model.dart';

class SubmissionAPI {
  // create test1 submission by username
  Future<Test1CreateSubmission> createTest1Submission(String username, List<dynamic> submission, String testName) async {
    final response = await http.post(Uri.parse('http://cosmoquizz-api.herokuapp.com/submissions/${username}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'submission': submission,
        'testName': testName,
      }),
    );
    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      Test1CreateSubmission test1CreateSubmission = Test1CreateSubmission.fromJson(jsonResponse);
      return test1CreateSubmission;
    } else {
      throw Exception('Failed to create test1 submission.');
    }
  }

  // get submissions by username
  Future<GetSubmissions> getSubmissions(String username) async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/submissions/${username}'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetSubmissions result = GetSubmissions.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve submissions.');
    }
  }

}
