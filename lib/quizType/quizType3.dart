import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:assistive_app/_helper/controller.dart';
import 'package:assistive_app/api/api.dart';
import 'package:assistive_app/components/Breadcrumps.dart';
import 'package:assistive_app/components/CorrectOrWrongCheck.dart';
import 'package:assistive_app/components/NextBeforeBtn.dart';
import 'package:assistive_app/components/SubmitBtn.dart';
import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/constants.dart';
import 'package:assistive_app/quizSucces/StageFail.dart';
import 'package:assistive_app/quizSucces/StageSuccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizType3 extends StatefulWidget {
  final int gradeid;
  final int level;
  final int subjectId;
  QuizType3({
    key,
    required this.gradeid,
    required this.level,
    required this.subjectId,
  }) : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType3> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();

  late int gradeid;
  late int questionId;
  late String title;
  var image = "https://deafapi.moodfor.codes/images/";

  late String imageFromDB;

  double _persentage = 0;
  int _total = 0;
  List<String> StringQues = [];
  List questionsFromDB = [];
  late int questionLength;

  List answersFromDB = [];

  late String gradeLevelQuestionID;

  List<int> saveindex = [];
  int currentIndex = 0;
  int correctAnswerCount = 0;
  bool isCorrectAnswer = false;

  String? _answerQNo;

  String? _answer;
  String? _correctanswer;
  String? _question = "1";
  bool _hasBeenPressed = false;
  String? _hasBeenPressedValue;

  //initialize list  for add questions from API
  List<dynamic> _foundQuestions = [];
  List _QuestionsFromDB = [];

// loader
  bool _isLoading = true;
  int isAnswer = 0;
  bool isAnswerCheck = false;
  int? userSelectedAnswer;

  @override
  void initState() {
    _apiGetQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: BaseAppBar(
        bacKText: "திரும்பிச் செல்",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: _isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(child: CupertinoActivityIndicator()),
                  )
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       NextBeforeBtn(text: 'முந்திய', function: (){}),
                      //       NextBeforeBtn(text: 'அடுத்து', function: (){})
                      //     ],
                      //   ),
                      // ),
                      Center(
                        child: CachedNetworkImage(
                            height: 200,
                            width: 160,
                            imageUrl: image + imageFromDB,
                            imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.fill),
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: answersFromDB[0].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: isAnswerCheck
                                  ? () {}
                                  : () {
                                      setState(() {
                                        isAnswer = answersFromDB[0][index]
                                            ['is_answer'];
                                      });
                                      userSelectedAnswer = index;
                                      if (answersFromDB[0][index]
                                              ['is_answer'] ==
                                          1) {
                                        isCorrectAnswer = true;
                                      } else {
                                        isCorrectAnswer = false;
                                      }
                                      submitAnswer();
                                    },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                      color: userSelectedAnswer == index
                                          ? Colors.yellow
                                          : Colors.white,
                                      width: 2),
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Row(
                                        children: [
                                          ClipOval(
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              color: kPrimaryRedColor,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${index + 1}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Text(
                                                answersFromDB[0][index]
                                                    ['title'],
                                                style: GoogleFonts.muktaMalar(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    userSelectedAnswer == index
                                        ? CorrectOrWrong(
                                            isAnswerCheck: isAnswerCheck,
                                            correctAnswer: answersFromDB[0]
                                                [index]['is_answer'],
                                            questionType: 2,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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

                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                      await preferences.setInt('currentQuestionIndex', currentIndex--);
                                      currentIndex = (await preferences.getInt('currentQuestionIndex'))!;
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
                                      marksServices.apiUpdateResult(
                                          widget.gradeid,
                                          successPercent,
                                          widget.level);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StageSuccess(
                                              gradeid: widget.gradeid,
                                              correctAnswers:
                                                  correctAnswerCount,
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
                                              correctAnswers:
                                                  correctAnswerCount,
                                              totalQuestion: questionLength,
                                              successPercent: successPercent),
                                        ),
                                      );
                                    }
                                  } else {
                                    currentIndex++;

                                    SharedPreferences preferences = await SharedPreferences.getInstance();
                                    await preferences.setInt('currentQuestionIndex', currentIndex++);
                                    currentIndex = (await preferences.getInt('currentQuestionIndex'))!;
                                    await preferences.setInt('gradeid', widget.gradeid);
                                    await preferences.setInt('level', widget.level);
                                    await preferences.setInt('subjectId', widget.subjectId);
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
                  )),
      ),
    );
  }

  //get questions from grade ID details from api
  void _apiGetQuestions() async {
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
      imageFromDB = questionsFromDB[0][currentIndex]["image"];
      questionLength = questionsFromDB[0].length;
      gradeLevelQuestionID = "19-1";

      answersFromDB.clear();
      var bodyRoutesAns;
      int currentQuestionId = questionsFromDB[0][currentIndex]["id"];
      var resAns = await CallApi()
          .getAnswerByQuestionId('getAnswersByQuestionId/$currentQuestionId');
      bodyRoutesAns = json.decode(resAns.body);
      print(bodyRoutesAns);
      // Add Answers to answersFromDB List
      answersFromDB.add(bodyRoutesAns);
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
