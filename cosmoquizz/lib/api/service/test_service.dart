import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '/api/model/test_model.dart';

class TestService {
  // get all test names
  Future<GetAllTests> getAllTests() async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/tests'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetAllTests result = GetAllTests.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve test names.');
    }
  }

  // get test info by test name
  Future<GetTest> getTest(String testName) async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/tests/${testName}'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetTest result = GetTest.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve test info.');
    }
  }
}
