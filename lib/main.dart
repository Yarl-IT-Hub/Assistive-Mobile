import 'dart:io';

import 'package:assistive_app/Login/login.dart';
import 'package:assistive_app/Subject/subject.dart';
import 'package:assistive_app/questionLock/QuestionLock.dart';
import 'package:assistive_app/quizType/quizType1.dart';
import 'package:assistive_app/quizType/quizType2.dart';
import 'package:assistive_app/quizType/quizType3.dart';
import 'package:assistive_app/quizType/quizType4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? loggedIn;
int? gradeid;
int? level;
int? subid;
int? initScreen;
String? routeValue;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  loggedIn = await localStorage.getInt('userId');
  gradeid = await localStorage.getInt('gradeid');
  level = await localStorage.getInt('level');
  subid = await localStorage.getInt('subjectId');
  initScreen = await localStorage.getInt('initScreen');
  print("gradeid - ${gradeid} | level - ${level} |  subid - ${subid}");
  // routeValue = 'SubjectPage';
  if(level == 1){
    routeValue = 'QuizType1';
  } else if(level == 2){
    routeValue = 'QuizType2';
  } else if(level == 3){
    routeValue = 'QuizTyp32';
  } else if(level == 4){
    routeValue = 'QuizType4';
  } else {
    routeValue = 'SubjectPage';
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assistive APP',
        theme: ThemeData(),
        initialRoute:
            loggedIn == 0 || loggedIn == null ? 'Login' : routeValue,
        routes: {
          'Login': (context) => LoginPage(),
          'SubjectPage': (context) => SubjectPage(),
          // 'SubjectPage': (context) => QuestionLockPage(
          //       gradeid: gradeid!,
          //       level: level!,
          //       subjectId: subid!,
          // ),
           'QuizType1': (context) =>  QuizType1(gradeid: gradeid!, level: level!, subjectId: subid!),
           'QuizType2': (context) =>  QuizType2(gradeid: gradeid!, level: level!, subjectId: subid!),
           'QuizType3': (context) =>  QuizType3(gradeid: gradeid!, level: level!, subjectId: subid!),
           'QuizType4': (context) =>  QuizType4(gradeid: gradeid!, level: level!, subjectId: subid!)
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
