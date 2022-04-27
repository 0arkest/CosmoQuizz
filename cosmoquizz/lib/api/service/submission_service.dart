import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '/api/model/submission_model.dart';

class SubmissionService {
  // create submission by username
  Future<PostSubmission> createSubmission(String username, List<dynamic> submission, String testName) async {
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
      PostSubmission postSubmission = PostSubmission.fromJson(jsonResponse);
      return postSubmission;
    } else {
      throw Exception('Failed to create submission.');
    }
  }

  // get all submissions by username
  Future<GetSubmissionsOfUser> getSubmissionsOfUser(String username) async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/submissions/${username}'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetSubmissionsOfUser result = GetSubmissionsOfUser.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve submissions.');
    }
  }

  // get all submissions by test name
  Future<GetSubmissionsOfTest> getSubmissionsOfTest(String testName) async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/tests/submissions/${testName}'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetSubmissionsOfTest result = GetSubmissionsOfTest.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve submissions.');
    }
  }

  // get specific submission by username and test name
  Future<GetSubmission> getSubmission(String username, String testName) async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/submissions/${username}/${testName}'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetSubmission result = GetSubmission.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve submission.');
    }
  }
}
