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

  const PostTeacher({
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

// get teacher by username
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
