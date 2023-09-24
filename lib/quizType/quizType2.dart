import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assistive_app/_helper/controller.dart';
import 'package:assistive_app/api/api.dart';
import 'package:assistive_app/components/Breadcrumps.dart';
import 'package:assistive_app/components/CorrectOrWrongCheck.dart';
import 'package:assistive_app/components/NextBeforeBtn.dart';
import 'package:assistive_app/components/SubmitBtn.dart';
import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/quizSucces/StageFail.dart';
import 'package:assistive_app/quizSucces/StageSuccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../questionLock/QuestionLock.dart';

class QuizType2 extends StatefulWidget {
  final int gradeid;
  final int level;
  final int subjectId;
  QuizType2({
    key,
    required this.gradeid,
    required this.level,
    required this.subjectId,
  }) : super(key: key);

  @override
  _Quiz1PageState createState() => _Quiz1PageState();
}

class _Quiz1PageState extends State<QuizType2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();
  late int gradeid;
  late int questionId;
  late String title;
  List questionsFromDB = [];
  late int questionLength;

  late String gradeLevelQuestionID;

  List<int> saveindex = [];
  int currentIndex = 0;
  int correctAnswerCount = 0;
  bool isCorrectAnswer = false;

  double _persentage = 0;
  int _total = 0;
  List<String> StringQues = [];

  String? _answerQNo;

  String? _answer;
  String? _correctanswer;
  String? _question = "1";
  bool _hasBeenPressed = false;
  String? _hasBeenPressedValue;

  //initialize list  for add questions from API
  List<dynamic> _foundAnswers = [];
  List _AnswersFromDB = [];

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
    var image = "https://deafapi.moodfor.codes/images/";

    return Scaffold(
      key: _scaffoldKey,
      appBar: BaseAppBar(
        bacKText: "திரும்பிச் செல்",
        appBar: AppBar(),
        function: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionLockPage(
                gradeid: 19,
                level: 4,
                subjectId: 6,
              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.muktaMalar(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0),
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
                              child: Stack(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CachedNetworkImage(
                                      imageUrl: image +
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
                              ]),
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
                                  function: () async{
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
                                // print("currentIndex - ${currentIndex}");
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
                ),
        ),
      ),
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
      print("questionsFromDB.length");
      print(questionsFromDB.length);

      questionId = questionsFromDB[0][currentIndex]["id"];
      //print(questionsFromDB);
      title = questionsFromDB[0][currentIndex]["title"];
      questionLength = questionsFromDB[0].length;
      gradeLevelQuestionID = "19-1";

      _AnswersFromDB.clear();
      var bodyRoutesAns;
      int currentQuestionId = questionsFromDB[0][currentIndex]["id"];
      var resAns = await CallApi().getAnswerByQuestionId('getAnswersByQuestionId/$currentQuestionId');
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
