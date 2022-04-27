import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '/api/model/teacher_model.dart';

class TeacherService {
  // create new teacher
  Future<PostTeacher> createTeacher(String bio, String birthday, String firstName, String lastName, String phone, String subject, String school, String username, String email) async {
    final response = await http.post(Uri.parse('http://cosmoquizz-api.herokuapp.com/teachers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'bio': bio,
        'birthday': birthday,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'subject': subject,
        'school': school,
        'username': username,
        'email': email,
      }),
    );
    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      PostTeacher postTeacher = PostTeacher.fromJson(jsonResponse);
      return postTeacher;
    } else {
      throw Exception('Failed to create teacher.');
    }
  }

  // get teacher info by username
  Future<GetTeacher> getTeacher(String username) async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/teachers/${username}'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetTeacher result = GetTeacher.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve teacher info.');
    }
  }

  // get all students of teacher by username
  Future<GetStudentsOfTeacher> getStudentsOfTeacher(String username) async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/teachers/${username}/students'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetStudentsOfTeacher result = GetStudentsOfTeacher.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve students.');
    }
  }

  // get all teachers
  Future<GetAllTeachers> getAllTeachers() async {
    final response = await http.get(Uri.parse('http://cosmoquizz-api.herokuapp.com/teachers'));

    // if success
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      GetAllTeachers result = GetAllTeachers.fromJson(jsonResponse);
      return result;
    } else {
      throw Exception('Failed to retrieve teachers.');
    }
  }
}
