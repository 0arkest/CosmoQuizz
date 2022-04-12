// create test1 submission by username
class Test1CreateSubmission {
  final List<dynamic>? submission;
  final String? testName;

  const Test1CreateSubmission({
    required this.submission,
    required this.testName,
  });

  factory Test1CreateSubmission.fromJson(Map<String, dynamic> parsedJson) {
    return Test1CreateSubmission(
      submission: parsedJson['submission'],
      testName: parsedJson['testName'],
    );
  }
}

// get submissions by username
class GetSubmissions {
  final Submission0? submission0;

  GetSubmissions({
    required this.submission0,
  });

  factory GetSubmissions.fromJson(Map<String, dynamic> parsedJson) {
    return GetSubmissions(
      submission0: Submission0.fromJson(parsedJson["submission0"]),
    );
  }
}

class Submission0 {
  final List<dynamic>? item;

  Submission0({
    required this.item,
  });

  factory Submission0.fromJson(Map<String, dynamic> parsedJson) {
    //var list = parsedJson['item'] as List;
    //List<ItemClass> itemList = list.map((i) => ItemClass.fromJson(i)).toList();

    return Submission0(
      item: List<dynamic>.from(parsedJson["item"].map((x) => x)),
      //item: itemList,
    );
  }
}

class ItemClass {
  final String? createdBy;
  final Submission? submission;
  final String? testName;
  final String? username;

  ItemClass({
    required this.createdBy,
    required this.submission,
    required this.testName,
    required this.username,
  });

  factory ItemClass.fromJson(Map<String, dynamic> parsedJson) {
    return ItemClass(
      createdBy: parsedJson["createdBy"],
      submission: Submission.fromJson(parsedJson["submission"]),
      testName: parsedJson["testName"],
      username: parsedJson["username"],
    );
  }
}

class Submission {
  final DataQuestion? dataQuestion1;
  final DataQuestion? dataQuestion2;

  Submission({
    required this.dataQuestion1,
    required this.dataQuestion2,
  });

  factory Submission.fromJson(Map<String, dynamic> parsedJson) {
    return Submission(
      dataQuestion1: DataQuestion.fromJson(parsedJson["dataQuestion1"]),
      dataQuestion2: DataQuestion.fromJson(parsedJson["dataQuestion2"]),
    );
  }
}

class DataQuestion {
  final String? answer;
  final String? description;
  final String? providedAnswer;
  final String? type;

  DataQuestion({
    required this.answer,
    required this.description,
    required this.providedAnswer,
    required this.type,
  });

  factory DataQuestion.fromJson(Map<String, dynamic> parsedJson) {
    return DataQuestion(
      answer: parsedJson["answer"],
      description: parsedJson["description"],
      providedAnswer: parsedJson["providedAnswer"],
      type: parsedJson["type"],
    );
  }
}
