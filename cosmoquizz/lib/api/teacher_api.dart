import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import './models/teacher_model.dart';

class TeacherAPI {
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
}
