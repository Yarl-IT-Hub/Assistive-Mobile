import 'dart:convert';
import 'package:assistive_app/_helper/controller.dart';
import 'package:assistive_app/api/api.dart';
import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/components/levelappbar.dart';
import 'package:assistive_app/constants.dart';
import 'package:assistive_app/quiz/quiz1.dart';
import 'package:assistive_app/quizSucces/StageSuccess.dart';
import 'package:assistive_app/quizSucces/Stagefail.dart';
import 'package:assistive_app/quizType/quizType1.dart';
import 'package:assistive_app/quizType/quizType2.dart';
import 'package:assistive_app/quizType/quizType3.dart';
import 'package:assistive_app/quizType/quizType4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionLockPage extends StatefulWidget {
  QuestionLockPage(
      {Key? key,
      required this.gradeid,
      required this.level,
      required this.subjectId})
      : super(key: key);
  final int gradeid;
  final int level;
  final int subjectId;

  @override
  _LockPageState createState() => _LockPageState();
}

class _LockPageState extends State<QuestionLockPage> {
  MarksServices marksServices = MarksServices();
  int? gradeid;
  int? level;
  int? subjectId;
  //initialize list for add subjects from API
  List<dynamic> _foundSubject = [];
  List _SubjectsFromDB = [];

// loader
  bool _isLoading = false;

  int index = 1;
  List _lockCheck = [];

  @override
  void initState() {
    _apiLockCheck();
    gradeid = widget.gradeid;
    print(gradeid);
    level = widget.level;
    print(level);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var image = "https://deafapi.moodfor.codes/images/";
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: QuestionsBaseAppBar(
        bacKText: "திரும்பிச் செல்",
        appBar: AppBar(),
        gradeid: gradeid!,
        subjectId: widget.subjectId,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 25.0),
                child: Text(
                  "கற்றல் செயற்பாடுகள்",
                  style: GoogleFonts.muktaMalar(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            _isLoading
                ? Center(child: CupertinoActivityIndicator())
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // mainAxisSpacing: 25.0,
                        // crossAxisSpacing: 25.0,
                      ),
                      itemCount: widget.level,
                      itemBuilder: (BuildContext ctx, int index) {
                        //  index = 0;
                        return GestureDetector(
                          onTap: () async {
                            // SharedPreferences localStorage = await SharedPreferences.getInstance();
                            // gradeid = await localStorage.getInt('gradeid');
                            // await localStorage.setInt('gradeid', widget.gradeid);
                            // level = await localStorage.getInt('level');
                            // await localStorage.setInt('level', index);
                            // subjectId = await localStorage.getInt('subjectId');
                            // await localStorage.setInt('subjectId', widget.subjectId);
                            // print("level - ${localStorage.getInt('level')} | gradeid - ${localStorage.getInt('gradeid')} | subjectId - ${localStorage.getInt('subjectId')}");

                            print("shan ${index + 1}");
                            // print("length - ${_lockCheck.length}");
                            if (_lockCheck.length < index) {
                              popup(context, _lockCheck.length + 1, index + 1);
                            } else {
                              if (index + 1 == 1) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizType1(
                                      gradeid: widget.gradeid,
                                      level: index + 1,
                                      subjectId: widget.subjectId,
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  _apiLockCheck();
                                }
                              } else if (index + 1 == 2) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizType2(
                                      gradeid: widget.gradeid,
                                      level: index + 1,
                                      subjectId: widget.subjectId,
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  _apiLockCheck();
                                }
                              } else if (index + 1 == 3) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizType3(
                                      gradeid: widget.gradeid,
                                      level: index + 1,
                                      subjectId: widget.subjectId,
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  _apiLockCheck();
                                }
                              } else if (index + 1 == 4) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizType4(
                                      gradeid: widget.gradeid,
                                      level: index + 1,
                                      subjectId: widget.subjectId,
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  _apiLockCheck();
                                }
                              }

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Quiz1Page(
                              //             gradeid: widget.gradeid,
                              //             title: "",
                              //             level: index + 1,
                              //           )),
                              // );

                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: _lockCheck.length + 1 > index
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image(
                                        height: 20,
                                        image: AssetImage(
                                            _lockCheck.length + 1 > index
                                                ? 'assets/static/unlock.png'
                                                : 'assets/static/lock.png'),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: _lockCheck.length + 1 > index
                                    ? Colors.lightGreen.shade300
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> popup(BuildContext context, int firstText, int secondText) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text('நிலை $secondText ஐ திறக்க நீங்கள்',
                      style: GoogleFonts.muktaMalar(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('நிலை $firstText ஐ முடிக்க வேண்டும் ',
                      style: GoogleFonts.muktaMalar(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 130, height: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'சரி',
                          style: GoogleFonts.muktaMalar(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryRedColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(20))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _apiLockCheck() async {
    int? initScreen;
    int? gradeid;
    int? level;
    int? subjectId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = await preferences.getInt('initScreen');
    await preferences.setInt('initScreen', 1);
    // gradeid = await preferences.getInt('gradeid');
    // await preferences.setInt('gradeid', widget.gradeid);
    // level = await preferences.getInt('level');
    // await preferences.setInt('level', widget.level);
    // subjectId = await preferences.getInt('subjectId');
    // await preferences.setInt('subjectId', widget.subjectId);
    SharedPreferences storage = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    try {
      _lockCheck.clear();
      var bodyRoutes;

      var res = await CallApi().getQuestionsByGradeId(
          'user_results/findByUserId/${storage.getInt("userId")}/${widget.gradeid}');
      bodyRoutes = json.decode(res.body);

      print("bodyRoutes");
      print(bodyRoutes);
      bodyRoutes.forEach((data) => {
            _lockCheck.add({"level": data['level'], "result": data['result']})
          });

      print(_lockCheck);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    // final result = await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Calendar(),
    //     ));
  }
}
