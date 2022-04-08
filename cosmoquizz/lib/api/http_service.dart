import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './student_model.dart';
import './test_model.dart';

class HttpService {
  // get students
  Future<Student> getStudents() async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/students'));

    // success
    if (response.statusCode == 200) {
      /*
      List<dynamic> body = jsonDecode(response.body);

      List<Student> students = body.map(
        (dynamic x) => Student.fromJson(x),
      ).toList();
      */
      return Student.fromJson(jsonDecode(response.body));
      //return students;
    } else {
      throw "Unable to retrieve students.";
    }
  }
  
  // post student
  Future<Student> createStudent(String birthday, String emergencyContact, String firstName, int grade, String lastName, String school, String username, String email) async {
    final response = await http.post(Uri.parse('http://cosmoquizz-api.herokuapp.com/students'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'birthday': birthday,
        'emergencyContact': emergencyContact,
        'firstName': firstName,
        'grade': grade,
        'lastName': lastName,
        'school': school,
        'username': username,
        'email': email,
      }),
    );

    // success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      Student studentModel = Student.fromJson(jsonResponse);
      return studentModel;
    } else {
      throw Exception('Failed to create student.');
    }
  }

  // get test1
  Future<TestModel> getTest() async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/tests/test1'));

    // success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      TestModel testModel = TestModel.fromJson(jsonResponse);
      return testModel;
    } else {
      throw "Unable to get test.";
    }
  }

}
