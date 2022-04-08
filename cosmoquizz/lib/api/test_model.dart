// get test
class TestModel {
    final Data data;

    TestModel({
       required this.data,
    });

    factory TestModel.fromJson(Map<String, dynamic> parsedJson) {
      return TestModel(
        data: Data.fromJson(parsedJson["data"]),
      );
    }

    /*
    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
    */
}

class Data {
    final String createdBy;
    final Questions questions;
    final String testName;

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

    /*
    Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "questions": questions.toJson(),
        "testName": testName,
    };
    */
}

class Questions {
    final DataQuestion dataQuestion1;
    final DataQuestion dataQuestion2;

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

    /*
    Map<String, dynamic> toJson() => {
        "dataQuestion1": dataQuestion1.toJson(),
        "dataQuestion2": dataQuestion2.toJson(),
    };
    */
}

class DataQuestion {
    final String answer;
    final String description;
    final String type;

    
    DataQuestion({
       required this.answer,
       required this.description,
       required this.type,
    });

    factory DataQuestion.fromJson(Map<String, dynamic> json) {
      return DataQuestion(
        answer: json["answer"],
        description: json["description"],
        type: json["type"],
      );
    }
    /*
    Map<String, dynamic> toJson() => {
        "answer": answer,
        "description": description,
        "type": type,
    };
    */
}
