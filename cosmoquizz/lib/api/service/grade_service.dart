import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '/api/model/grade_model.dart';

class GradeService {
  // create grade by username and test name
  Future<PostGrade> createGrade(String username, String testName, int grade) async {
    final response = await http.post(Uri.parse('http://cosmoquizz-api.herokuapp.com/grades/${username}/${testName}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'grade': grade,
      }),
    );
    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      PostGrade postGrade = PostGrade.fromJson(jsonResponse);
      return postGrade;
    } else {
      throw Exception('Failed to create grade.');
    }
  }

  // get grade by username
  Future<GetGrade> getGrade(String username) async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/grades/${username}'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetGrade result = GetGrade.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve grade.');
    }
  }
}
