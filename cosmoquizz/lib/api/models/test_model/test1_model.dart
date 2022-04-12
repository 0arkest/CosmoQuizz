// get test1
class GetTest1 {
  final Data? data;

  GetTest1({
    required this.data,
  });

  factory GetTest1.fromJson(Map<String, dynamic> parsedJson) {
    return GetTest1(
      data: Data.fromJson(parsedJson["data"]),
    );
  }
}

class Data {
  final String? createdBy;
  final Questions? questions;
  final String? testName;

  Data({
    required this.createdBy,
    required this.questions,
    required this.testName,
  });

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      createdBy: parsedJson["createdBy"],
      questions: Questions.fromJson(parsedJson["questions"]),
      testName: parsedJson["testName"],
    );
  }
}

class Questions {
  final DataQuestion? dataQuestion1;
  final DataQuestion? dataQuestion2;

  Questions({
    required this.dataQuestion1,
    required this.dataQuestion2,
  });

  factory Questions.fromJson(Map<String, dynamic> parsedJson) {
    return Questions(
      dataQuestion1: DataQuestion.fromJson(parsedJson["dataQuestion1"]),
      dataQuestion2: DataQuestion.fromJson(parsedJson["dataQuestion2"]),
    );
  }
}

class DataQuestion {
  final String? answer;
  final String? description;
  final String? type;

  
  DataQuestion({
    required this.answer,
    required this.description,
    required this.type,
  });

  factory DataQuestion.fromJson(Map<String, dynamic> parsedJson) {
    return DataQuestion(
      answer: parsedJson["answer"],
      description: parsedJson["description"],
      type: parsedJson["type"],
    );
  }
}
