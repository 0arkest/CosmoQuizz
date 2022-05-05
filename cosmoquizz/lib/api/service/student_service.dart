import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '/api/model/student_model.dart';

class StudentService {
  // create new student
  Future<PostStudent> createStudent(String birthday, String emergencyContact, String firstName, int grade, String lastName, String school, String username, String email) async {
    final response = await http.post(Uri.parse('https://cosmoquizz-api.herokuapp.com/students'),
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
    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      PostStudent postStudent = PostStudent.fromJson(jsonResponse);
      return postStudent;
    } else {
      throw Exception('Failed to create student.');
    }
  }

  // get student info by username
  Future<GetStudent> getStudent(String username) async {
    final response = await http.get(Uri.parse('https://cosmoquizz-api.herokuapp.com/students/${username}'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetStudent result = GetStudent.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve student info.');
    }
  }

  // get all teachers of student by username
  Future<GetTeachersOfStudent> getTeachersOfStudent(String username) async {
    final response = await http.get(Uri.parse('https://cosmoquizz-api.herokuapp.com/students/${username}/teachers'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetTeachersOfStudent result = GetTeachersOfStudent.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve teachers.');
    }
  }

  // get all students
  Future<GetAllStudents> getAllStudents() async {
    final response = await http.get(Uri.parse('https://cosmoquizz-api.herokuapp.com/students'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetAllStudents result = GetAllStudents.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve students.');
    }
  }
}
