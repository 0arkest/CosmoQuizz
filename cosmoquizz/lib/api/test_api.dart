import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import './models/test_model/test1_model.dart';

class TestAPI {
  // get test1
  Future<GetTest1> getTest1() async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/tests/test1'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetTest1 test1 = GetTest1.fromJson(jsonResponse);
      return test1;
    } else {
      throw Exception('Failed to retrieve test1 info.');
    }
  }

}
