// import 'dart:convert';
// import 'package:assistive_app/api/api.dart';
// import 'package:assistive_app/components/appbar.dart';
// import 'package:assistive_app/quizType/quizType1.dart';
// import 'package:assistive_app/quizType/quizType2.dart';
// import 'package:assistive_app/quizType/quizType3.dart';
// import 'package:assistive_app/quizType/quizType4.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Quiz1Page extends StatefulWidget {
//   Quiz1Page(
//       {Key? key,
//       required this.title,
//       required this.gradeid,
//       required this.level})
//       : super(key: key);

//   final String title;
//   final int gradeid;
//   final int level;

//   @override
//   _Quiz1PageState createState() => _Quiz1PageState();
// }

// class _Quiz1PageState extends State<Quiz1Page> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   List questionsFromDB = [];
//   bool _isLoading = false;

//   @override
//   void initState() {
//     print("gradeid ${widget.gradeid} / level ${widget.level}");
//     _apiGetQuestions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: BaseAppBar(
//         bacKText: "திரும்பிச் செல்",
//         appBar: AppBar(),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//                 left: 30, right: 20.0, top: 20, bottom: 20),
//             child: Text(
//               'நிலை ${widget.level}',
//               style: GoogleFonts.muktaMalar(
//                 fontSize: 20,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           !_isLoading
//               ? questionsFromDB.length == 0
//                   ? Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Align(child: Text("No Questions available")),
//                     )
//                   : Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         //list

//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: questionsFromDB[0].length,
//                           //   itemBuilder: (context, index_Q) {
//                           itemBuilder: (context, index) {
//                             return new Card(
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 side: BorderSide(
//                                   color: Colors.black12,
//                                   width: 1.0,
//                                 ),
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                               child: ListTile(
//                                 onTap: () {
//                                   print("Question type");
//                                   print(questionsFromDB[0][index]["type_id"]);
//                                   setState(
//                                     () {
//                                       if (questionsFromDB[0][index]
//                                               ["type_id"] ==
//                                           1) {
//                                         setState(
//                                           () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => QuizType1(
//                                                   gradeid: widget.gradeid,
//                                                   level: widget.level,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       } else if (questionsFromDB[0][index]
//                                               ["type_id"] ==
//                                           2) {
//                                         setState(
//                                           () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => QuizType2(
//                                                   // title: questionsFromDB[0]
//                                                   //     [index]['title'],
//                                                   // questionId:
//                                                   //     questionsFromDB[0]
//                                                   //         [index]['id'],
//                                                   // gradeLevelQuestionID:
//                                                   //     '${widget.gradeid}-${widget.level}',
//                                                   // // questionLength:
//                                                   //     questionsFromDB[0]
//                                                   //         .length,
//                                                   gradeid: widget.gradeid,
//                                                   level: widget.level,
//                                                   //questionIndex: index
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       } else if (questionsFromDB[0][index]
//                                               ["type_id"] ==
//                                           3) {
//                                         print(questionsFromDB[0][index]);
//                                         setState(
//                                           () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => QuizType3(
//                                                   // questionId:
//                                                   //     questionsFromDB[0]
//                                                   //         [index]['id'],
//                                                   // title: questionsFromDB[0]
//                                                   //     [index]['title'],
//                                                   // image: questionsFromDB[0]
//                                                   //     [index]['image'],
//                                                   // gradeLevelQuestionID:
//                                                   //     '${widget.gradeid}-${widget.level}',
//                                                   // questionLength:
//                                                   //     questionsFromDB[0]
//                                                   //         .length,
//                                                   gradeid: widget.gradeid,
//                                                   level: widget.level,
//                                                   //questionIndex: index
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       } else if (questionsFromDB[0][index]
//                                               ["type_id"] ==
//                                           4) {
//                                         setState(
//                                           () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => QuizType4(
//                                                   // questionId:
//                                                   //     questionsFromDB[0]
//                                                   //         [index]['id'],
//                                                   // title: questionsFromDB[0]
//                                                   //     [index]['title'],
//                                                   // gradeLevelQuestionID:
//                                                   //     '${widget.gradeid}-${widget.level}',
//                                                   // questionLength:
//                                                   //     questionsFromDB[0]
//                                                   //         .length,
//                                                   gradeid: widget.gradeid,
//                                                   level: widget.level,
//                                                   // questionIndex: index
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       }
//                                     },
//                                   );
//                                 },
//                                 title: Text(
//                                   questionsFromDB[0][index]['title'],
//                                   // textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     )
//               : Padding(
//                   padding: const EdgeInsets.only(top: 100.0, left: 180),
//                   child: CupertinoActivityIndicator(),
//                 ),
//         ],
//       ),
//     );
//   }

// //get questions from grade ID details from api
//   void _apiGetQuestions() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       questionsFromDB.clear();
//       var bodyRoutes;
//       var res = await CallApi().getQuestionsByGradeId(
//           'questionsByGradeId/${widget.gradeid}/${widget.level}');
//       bodyRoutes = json.decode(res.body);

//       // Add Questions to questionsFromDB List
//       print(bodyRoutes);
//       if (bodyRoutes['errorMessage'] == true) {
//         questionsFromDB.add(bodyRoutes['data']);
//       }
//     } catch (e) {
//       print(e);
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }
