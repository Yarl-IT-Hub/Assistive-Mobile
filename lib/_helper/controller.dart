import 'dart:convert';

import 'package:assistive_app/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarksServices {
  // set user id - this should be add when user login but now I'm using this for dev purpose
  userSet() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt("userId", 269);
    // storage.remove("userId");
    print(storage.getInt("userId"));
  }

  // Add results to local storage list
  addResults(gradeLevelQuestionID, questionId, points) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    final myStringList = storage.getStringList('resultList') ?? [];
    var checkContains = myStringList.where((item) {
      return item.contains("${gradeLevelQuestionID}-${questionId}"); // id
    });
    if (checkContains.length == 0) {
      print("0 length");
      myStringList.add(json.encode(
          {"id": "${gradeLevelQuestionID}-${questionId}", "results": points}));
      storage.setStringList('resultList', myStringList);
    }
    print("myStringList");
    print(myStringList);
  }

  // get result list from local storage
  Future getResultList() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final myStringList = storage.getStringList('resultList') ?? [];
    return myStringList;
  }

  // get result list from local storage
  Future<int> getCorrectAnswers() async {
    var correctAnswers = 0;
    SharedPreferences storage = await SharedPreferences.getInstance();
    final myStringList = storage.getStringList('resultList') ?? [];

    for (var data in myStringList) {
      int result = jsonDecode(data)['results'];
      correctAnswers = correctAnswers + result;
    }
    return correctAnswers;
  }

  // Find total marks and average
  Future<double> findAverage(questionLength) async {
    var correctAnswers = 0;
    SharedPreferences storage = await SharedPreferences.getInstance();
    final myStringList = storage.getStringList('resultList') ?? [];

    for (var data in myStringList) {
      int result = jsonDecode(data)['results'];
      correctAnswers = correctAnswers + result;
    }
    print("total - ${correctAnswers}");
    var average = (100 / questionLength) * correctAnswers;
    print("average - ${average}");
    storage.setDouble("results", average);
    return average;
  }

  // delete all the local storages
  deleteAllLocalStorage() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.remove("results");
    storage.remove("resultList");
  }

  // API update result on DB
  void apiUpdateResult(gradeId, results, level) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    try {
      var bodyRoutes;

      var data = {
        "user_id": storage.getInt("userId"),
        "grade_id": gradeId,
        "result": results,
        "level": level
      };

      var res = await CallApi().postData(data, 'user_results');
      bodyRoutes = json.decode(res.body);
      print(bodyRoutes);

      //delete list
      deleteAllLocalStorage();
    } catch (e) {
      print(e);
    }
  }
}
