import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import './models/grade_model.dart';

class GradeAPI {
  // get grade of user 'weic4399'
  Future<GetGrade_weic4399> getGrade_weic4399() async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/grades/weic4399'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetGrade_weic4399 result = GetGrade_weic4399.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve grade.');
    }
  }

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

}
