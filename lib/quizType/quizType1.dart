import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assistive_app/_helper/controller.dart';
import 'package:assistive_app/api/api.dart';
import 'package:assistive_app/components/Breadcrumps.dart';
import 'package:assistive_app/components/CorrectOrWrongCheck.dart';
import 'package:assistive_app/components/NextBeforeBtn.dart';
import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/quizSucces/StageSuccess.dart';
import 'package:assistive_app/quizSucces/Stagefail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizType1 extends StatefulWidget {
  final int gradeid;
  final int level;
  final int subjectId;
  QuizType1({
    key,
    required this.gradeid,
    required this.level,
    required this.subjectId,
  }) : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();
  List questionsFromDB = [];
  late int gradeid;
  late int questionId;
  late int questionLength;

  late String image;
  late String gradeLevelQuestionID;

  List<int> saveindex = [];
  late int currentIndex = 0;
  int correctAnswerCount = 0;
  List<String> StringQues = [];

  //initialize list  for add questions from API
  // List<dynamic> _foundAnswers = [];
  List _AnswersFromDB = [];

// loader
  bool _isLoading = true;
  var ans;

  var _answer = null;
  int isAnswer = 0;
  bool isAnswerCheck = false;
  bool isCorrectAnswer = false;
  int? userSelectedAnswer;

  @override
  void initState() {
    _apiGetQuestions();

    //_apiGetAnswers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var imageUrl = "https://deafapi.moodfor.codes/images/";
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: BaseAppBar(
        bacKText: "திரும்பிச் செல்",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        child: _isLoading
            ? Center(
                child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: CupertinoActivityIndicator(),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Breadcrumbs(
                      title:
                          'நிலை ${widget.level} > கேள்வி ${currentIndex + 1}',
                    ),
                  ),
                  Center(
                    child: CachedNetworkImage(
                      height: 200,
                      width: 160,
                      imageUrl: imageUrl + image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GridView.builder(
                      shrinkWrap: true,

                      /// physics:
                      //   const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // childAspectRatio: 9/10,
                        mainAxisSpacing: 5.0,
                        // crossAxisSpacing: 25.0
                      ),
                      itemCount: _AnswersFromDB[0].length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: isAnswerCheck
                              ? () {}
                              : () {
                                  setState(() {
                                    isAnswer =
                                        _AnswersFromDB[0][index]['is_answer'];
                                  });
                                  userSelectedAnswer = index;
                                  if (_AnswersFromDB[0][index]['is_answer'] ==
                                      1) {
                                    isCorrectAnswer = true;
                                  } else {
                                    isCorrectAnswer = false;
                                  }

                                  submitAnswer();
                                },
                          child: Card(
                            color: userSelectedAnswer == index
                                ? Colors.yellow
                                : null,
                            elevation: 0,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CachedNetworkImage(
                                      // height: 150,
                                      // width: 160,
                                      imageUrl: imageUrl +
                                          _AnswersFromDB[0][index]['image'],
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error)),
                                ),
                                userSelectedAnswer == index
                                    ? CorrectOrWrong(
                                        isAnswerCheck: isAnswerCheck,
                                        correctAnswer: _AnswersFromDB[0][index]
                                            ['is_answer'],
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        currentIndex != 0
                            ? NextBeforeBtn(
                                text: 'முந்திய',
                                function: () async {
                                  currentIndex--;

                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.setInt(
                                      'currentQuestionIndex', currentIndex--);
                                  currentIndex = (await preferences
                                      .getInt('currentQuestionIndex'))!;
                                  print("currentQuestionIndex ${currentIndex}");

                                  setState(() {
                                    _isLoading = true;
                                    _apiGetQuestions();
                                  });
                                })
                            : SizedBox(),
                        NextBeforeBtn(
                            text: 'அடுத்து',
                            function: () async {
                              if (questionLength == currentIndex + 1) {
                                double successPercent =
                                    (correctAnswerCount.toDouble() /
                                            questionLength) *
                                        100;

                                if (successPercent >= 50 &&
                                    currentIndex + 1 == questionLength) {
                                  marksServices.apiUpdateResult(widget.gradeid,
                                      successPercent, widget.level);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StageSuccess(
                                          gradeid: widget.gradeid,
                                          correctAnswers: correctAnswerCount,
                                          totalQuestions: questionLength,
                                          successPercent: successPercent,
                                          level: widget.level,
                                          subjectId: widget.subjectId),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StageFail(
                                          correctAnswers: correctAnswerCount,
                                          totalQuestion: questionLength,
                                          successPercent: successPercent),
                                    ),
                                  );
                                }
                              } else {
                                currentIndex++;

                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences.setInt(
                                    'currentQuestionIndex', currentIndex++);
                                currentIndex = (await preferences
                                    .getInt('currentQuestionIndex'))!;
                                await preferences.setInt(
                                    'gradeid', widget.gradeid);
                                await preferences.setInt('level', widget.level);
                                await preferences.setInt(
                                    'subjectId', widget.subjectId);
                                print("currentQuestionIndex ${currentIndex}");
                              }
                              setState(() {
                                _isLoading = true;
                                _apiGetQuestions();
                              });
                            })
                      ],
                    ),
                  ),
                ],
              ),
      )),
    );
  }

  //get questions from grade ID details from api
  void _apiGetQuestions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    currentIndex = await preferences.getInt("currentQuestionIndex") ?? 0;
    // if(currentIndex)
    print("currentQuestionIndex ${currentIndex}");

    try {
      userSelectedAnswer = null;
      isAnswerCheck = false;
      questionsFromDB.clear();
      var bodyRoutes;
      int grade = widget.gradeid;
      int level = widget.level;
      var res = await CallApi()
          .getQuestionsByGradeId('questionsByGradeId/$grade/$level');
      bodyRoutes = json.decode(res.body);

      // Add Questions to questionsFromDB List
      print(bodyRoutes);

      if (bodyRoutes['errorMessage'] == true) {
        questionsFromDB.add(bodyRoutes['data']);
      }
      print(questionsFromDB.length);

      questionId = questionsFromDB[0][currentIndex]["id"];
      //print(questionsFromDB);
      image = questionsFromDB[0][currentIndex]["image"];
      questionLength = questionsFromDB[0].length;
      gradeLevelQuestionID = "19-1";

      _AnswersFromDB.clear();
      var bodyRoutesAns;
      int currentQuestionId = questionsFromDB[0][currentIndex]["id"];
      var resAns = await CallApi()
          .getAnswerByQuestionId('getAnswersByQuestionId/$currentQuestionId');
      bodyRoutesAns = json.decode(resAns.body);
      print(bodyRoutesAns);
      // Add Answers to _AnswersFromDB List
      _AnswersFromDB.add(bodyRoutesAns);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void submitAnswer() async {
    if (userSelectedAnswer != null) {
      print(saveindex);
      print(currentIndex);
      if (isCorrectAnswer) {
        if (saveindex.contains(currentIndex)) {
        } else {
          correctAnswerCount++;
          saveindex.add(currentIndex);
        }
      }
      setState(() {
        isAnswerCheck = true;
      });
    }
  }
}
