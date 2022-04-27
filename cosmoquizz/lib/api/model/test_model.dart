// get all test names
class GetAllTests {
  final List<dynamic>? tests;

  GetAllTests({
    required this.tests,
  });

  factory GetAllTests.fromJson(Map<String, dynamic> parsedJson) {
    return GetAllTests(
      tests: List<dynamic>.from(parsedJson["tests"].map((x) => x)),
    );
  }
}

// get test info by test name
class GetTest {
  final Data? data;

  GetTest({
    required this.data,
  });

  factory GetTest.fromJson(Map<String, dynamic> parsedJson) {
    return GetTest(
      data: Data.fromJson(parsedJson["data"]),
    );
  }
}

class Data {
  final String? createdBy;
  final List<Question>? questions;
  final String? testName;

  Data({
    required this.createdBy,
    required this.questions,
    required this.testName,
  });

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      createdBy: parsedJson["createdBy"],
      questions: List<Question>.from(parsedJson["questions"].map((x) => Question.fromJson(x))),
      testName: parsedJson["testName"],
    );
  }
}

class Question {
  final String? answer;
  final String? description;
  final String? number;
  final String? options;
  final String? type;

  
  Question({
    required this.answer,
    required this.description,
    required this.number,
    required this.options,
    required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> parsedJson) {
    return Question(
      answer: parsedJson["answer"],
      description: parsedJson["description"],
      number: parsedJson["number"],
      options: parsedJson["options"],
      type: parsedJson["type"],
    );
  }
}
