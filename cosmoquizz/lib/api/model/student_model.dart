// create new student
class PostStudent {
  final String? birthday;
  final String? emergencyContact;
  final String? firstName;
  final int? grade;
  final String? lastName;
  final String? school;
  final String? username;
  final String? email;

  PostStudent({
    required this.birthday,
    required this.emergencyContact,
    required this.firstName,
    required this.grade,
    required this.lastName,
    required this.school,
    required this.username,
    required this.email,
  });

  factory PostStudent.fromJson(Map<String, dynamic> parsedJson) {
    return PostStudent(
      birthday: parsedJson['birthday'],
      emergencyContact: parsedJson['emergencyContact'],
      firstName: parsedJson['firstName'],
      grade: parsedJson['grade'],
      lastName: parsedJson['lastName'],
      school: parsedJson['school'],
      username: parsedJson['username'],
      email: parsedJson['email'],
    );
  }
}

// get student info by username
class GetStudent {
  final Data? data;

  GetStudent({
    required this.data,
  });

  factory GetStudent.fromJson(Map<String, dynamic> parsedJson) {
    return GetStudent(
      data: Data.fromJson(parsedJson["data"]),
    );
  }
}

class Data {
  final String? birthday;
  final String? email;
  final String? emergencyContact;
  final String? firstName;
  final int? grade;
  final String? lastName;
  final String? school;
  final String? username;

  Data({
    required this.birthday,
    required this.email,
    required this.emergencyContact,
    required this.firstName,
    required this.grade,
    required this.lastName,
    required this.school,
    required this.username,
  });

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      birthday: parsedJson["birthday"],
      email: parsedJson["email"],
      emergencyContact: parsedJson["emergencyContact"],
      firstName: parsedJson["firstName"],
      grade: parsedJson["grade"],
      lastName: parsedJson["lastName"],
      school: parsedJson["school"],
      username: parsedJson["username"],
    );
  }
}

// get all teachers of student by username
class GetTeachersOfStudent {
  final List<dynamic>? teachers;

  GetTeachersOfStudent({
    required this.teachers,
  });

  factory GetTeachersOfStudent.fromJson(Map<String, dynamic> parsedJson) {
    return GetTeachersOfStudent(
      teachers: List<dynamic>.from(parsedJson["teachers"].map((x) => x)),
    );
  }
}

// get all students
class GetAllStudents {
  final List<Student>? students;

  GetAllStudents({
    required this.students,
  });

  factory GetAllStudents.fromJson(Map<String, dynamic> parsedJson) {
    return GetAllStudents(
      students: List<Student>.from(parsedJson["students"].map((x) => Student.fromJson(x))),
    );
  }
}

class Student {
  final String? birthday;
  final String? email;
  final String? emergencyContact;
  final String? firstName;
  final int? grade;
  final String? lastName;
  final String? school;
  final String? username;

  Student({
    required this.birthday,
    required this.email,
    required this.emergencyContact,
    required this.firstName,
    required this.grade,
    required this.lastName,
    required this.school,
    required this.username,
  });

  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      birthday: parsedJson["birthday"],
      email: parsedJson["email"],
      emergencyContact: parsedJson["emergencyContact"],
      firstName: parsedJson["firstName"],
      grade: parsedJson["grade"],
      lastName: parsedJson["lastName"],
      school: parsedJson["school"],
      username: parsedJson["username"],
    );
  }
}
