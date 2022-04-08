// post student
class Student {
  final String birthday;
  final String emergencyContact;
  final String firstName;
  final int grade;
  final String lastName;
  final String school;
  final String username;
  final String email;

  const Student({
    required this.birthday,
    required this.emergencyContact,
    required this.firstName,
    required this.grade,
    required this.lastName,
    required this.school,
    required this.username,
    required this.email
  });

  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
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
  
  /*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthday'] = birthday;
    data['emergencyContact'] = emergencyContact;
    data['firstName'] = firstName;
    data['grade'] = grade;
    data['lastName'] = lastName;
    data['school'] = school;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
  */
  
}
