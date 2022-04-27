// create new teacher
class PostTeacher {
  final String? bio;
  final String? birthday;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? subject;
  final String? school;
  final String? username;
  final String? email;

  PostTeacher({
    required this.bio,
    required this.birthday,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.subject,
    required this.school,
    required this.username,
    required this.email,
  });

  factory PostTeacher.fromJson(Map<String, dynamic> parsedJson) {
    return PostTeacher(
      bio: parsedJson['bio'],
      birthday: parsedJson['birthday'],
      firstName: parsedJson['firstName'],
      lastName: parsedJson['lastName'],
      phone: parsedJson['phone'],
      subject: parsedJson['subject'],
      school: parsedJson['school'],
      username: parsedJson['username'],
      email: parsedJson['email'],
    );
  }
}

// get teacher info by username
class GetTeacher {
  final Data? data;

  GetTeacher({
    required this.data,
  });

  factory GetTeacher.fromJson(Map<String, dynamic> parsedJson) {
    return GetTeacher(
      data: Data.fromJson(parsedJson["data"]),
    );
  }
}

class Data {
  final String? bio;
  final String? birthday;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? school;
  final String? subject;
  final String? username;
  final List<dynamic>? students;

  Data({
    required this.bio,
    required this.birthday,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.school,
    required this.subject,
    required this.username,
    required this.students,
  });

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      bio: parsedJson["bio"],
      birthday: parsedJson["birthday"],
      email: parsedJson["email"],
      firstName: parsedJson["firstName"],
      lastName: parsedJson["lastName"],
      phone: parsedJson["phone"],
      school: parsedJson["school"],
      subject: parsedJson["subject"],
      username: parsedJson["username"],
      students: List<dynamic>.from(parsedJson["students"].map((x) => x)),
    );
  }
}

// get all students of teacher by username
class GetStudentsOfTeacher {
  final List<dynamic>? data;

  GetStudentsOfTeacher({
    required this.data,
  });

  factory GetStudentsOfTeacher.fromJson(Map<String, dynamic> parsedJson) {
    return GetStudentsOfTeacher(
      data: List<dynamic>.from(parsedJson["data"].map((x) => x)),
    );
  }
}

// get all teachers
class GetAllTeachers {
  final List<Teacher>? teachers;

  GetAllTeachers({
    required this.teachers,
  });

  factory GetAllTeachers.fromJson(Map<String, dynamic> parsedJson) {
    return GetAllTeachers(
      teachers: List<Teacher>.from(parsedJson["teachers"].map((x) => Teacher.fromJson(x))),
    );
  }
}

class Teacher {
  final String? bio;
  final String? birthday;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? school;
  final List<dynamic>? students;
  final String? subject;
  final String? username;

  Teacher({
    required this.bio,
    required this.birthday,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.school,
    required this.students,
    required this.subject,
    required this.username,
  });

  factory Teacher.fromJson(Map<String, dynamic> parsedJson) {
    return Teacher(
      bio: parsedJson["bio"],
      birthday: parsedJson["birthday"],
      email: parsedJson["email"],
      firstName: parsedJson["firstName"],
      lastName: parsedJson["lastName"],
      phone: parsedJson["phone"],
      school: parsedJson["school"],
      students: List<dynamic>.from(parsedJson["students"].map((x) => x)),
      subject: parsedJson["subject"],
      username: parsedJson["username"],
    );
  }
}
