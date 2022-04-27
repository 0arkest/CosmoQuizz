// create grade by username and test name
class PostGrade {
  final int? grade;

  PostGrade({
    required this.grade,
  });

  factory PostGrade.fromJson(Map<String, dynamic> parsedJson) {
    return PostGrade(
      grade: parsedJson['grade'],
    );
  }
}

// get grade by username
class GetGrade {
  final List<Grade>? grades;

  GetGrade({
    required this.grades,
  });

  factory GetGrade.fromJson(Map<String, dynamic> parsedJson) {
    return GetGrade(
      grades: List<Grade>.from(parsedJson["grades"].map((x) => Grade.fromJson(x))),
    );
  }
}

class Grade {
  final String? testName;
  final int? grade;

  Grade({
    required this.testName,
    required this.grade,
  });

  factory Grade.fromJson(Map<String, dynamic> parsedJson) {
    return Grade(
      testName: parsedJson["testName"],
      grade: parsedJson["grade"],
    );
  }
}
