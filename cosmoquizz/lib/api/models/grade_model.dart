// get grade of user 'weic4399'
class GetGrade_weic4399 {
  final int? test1;

  const GetGrade_weic4399({
    required this.test1,
  });

  factory GetGrade_weic4399.fromJson(Map<String, dynamic> parsedJson) {
    return GetGrade_weic4399(
      test1: parsedJson['test1'],
    );
  }
}

// create grade by username and test name
class PostGrade {
  final int? grade;

  const PostGrade({
    required this.grade,
  });

  factory PostGrade.fromJson(Map<String, dynamic> parsedJson) {
    return PostGrade(
      grade: parsedJson['grade'],
    );
  }
}
