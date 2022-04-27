// create submission by username
class PostSubmission {
  final List<dynamic>? submission;
  final String? testName;

  PostSubmission({
    required this.submission,
    required this.testName,
  });

  factory PostSubmission.fromJson(Map<String, dynamic> parsedJson) {
    return PostSubmission(
      submission: parsedJson['submission'],
      testName: parsedJson['testName'],
    );
  }
}

// get all submissions by username
class GetSubmissionsOfUser {
  final List<Data>? data;

  GetSubmissionsOfUser({
    required this.data,
  });

  factory GetSubmissionsOfUser.fromJson(Map<String, dynamic> parsedJson) {
    return GetSubmissionsOfUser(
      data: List<Data>.from(parsedJson["data"].map((x) => Data.fromJson(x))),
    );
  }
}

class Data {
  final String? createdBy;
  final List<Submission>? submission;
  final String? testName;
  final String? username;

  Data({
    required this.createdBy,
    required this.submission,
    required this.testName,
    required this.username,
  });

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      createdBy: parsedJson["createdBy"],
      submission: List<Submission>.from(parsedJson["submission"].map((x) => Submission.fromJson(x))),
      testName: parsedJson["testName"],
      username: parsedJson["username"],
    );
  }
}

class Submission {
  final String? answer;
  final String? description;
  final String? number;
  final String? options;
  final String? providedAnswer;
  final String? type;

  
  Submission({
    required this.answer,
    required this.description,
    required this.number,
    required this.options,
    required this.providedAnswer,
    required this.type,
  });

  factory Submission.fromJson(Map<String, dynamic> parsedJson) {
    return Submission(
      answer: parsedJson["answer"],
      description: parsedJson["description"],
      number: parsedJson["number"],
      options: parsedJson["options"],
      providedAnswer: parsedJson["providedAnswer"],
      type: parsedJson["type"],
    );
  }
}

// get all submissions by test name. Reused some classes above
class GetSubmissionsOfTest {
  final List<Data>? data;

  GetSubmissionsOfTest({
    required this.data,
  });

  factory GetSubmissionsOfTest.fromJson(Map<String, dynamic> parsedJson) {
    return GetSubmissionsOfTest(
      data: List<Data>.from(parsedJson["data"].map((x) => Data.fromJson(x))),
    );
  }
}

// get specific submission by username and test name. Reused Submission class
class GetSubmission {
  final Data2? data;

  GetSubmission({
    required this.data,
  });

  factory GetSubmission.fromJson(Map<String, dynamic> parsedJson) {
    return GetSubmission(
      data: Data2.fromJson(parsedJson["data"]),
    );
  }
}

class Data2 {
  final String? createdBy;
  final int? grade;
  final List<Submission>? submission;
  final String? testName;
  final String? username;

  Data2({
    required this.createdBy,
    required this.grade,
    required this.submission,
    required this.testName,
    required this.username,
  });

  factory Data2.fromJson(Map<String, dynamic> parsedJson) {
    return Data2(
      createdBy: parsedJson["createdBy"],
      grade: parsedJson["grade"],
      submission: List<Submission>.from(parsedJson["submission"].map((x) => Submission.fromJson(x))),
      testName: parsedJson["testName"],
      username: parsedJson["username"],
    );
  }
}
