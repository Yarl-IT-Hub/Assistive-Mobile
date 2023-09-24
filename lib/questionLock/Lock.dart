// import 'package:assistive_app/Subject/subSubject.dart';
// import 'package:assistive_app/constants.dart';
// import 'package:assistive_app/quiz/quiz4.dart';
// import 'package:assistive_app/quiz/quiz3dart';
// import 'package:assistive_app/quiz/quiz2.dart';
// import 'package:assistive_app/quiz/quiz1.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LockPage extends StatefulWidget {
//   LockPage({Key? key, required this.nilai, required this.next_nilai})
//       : super(key: key);

//   final int nilai;
//   final int next_nilai;

//   @override
//   _LockPageState createState() => _LockPageState();
// }

// class _LockPageState extends State<LockPage> {
//   // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   // var formerSavedList;
//   // _incrementCounter() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();

//   //   formerSavedList = prefs.getStringList('finishLock') ?? ['0'];

//   //   var newElement = widget.nilai.toString();
//   //   // var newElement1 = widget.next_nilai;

//   //   if (formerSavedList.contains(newElement)) {
//   //   } else {
//   //     formerSavedList.add(newElement);
//   //   }
//   //   print('list $formerSavedList');
//   //   await prefs.setStringList('finishLock', formerSavedList);

//   //    print(formerSavedList[formerSavedList.length-1]);

//   // }

//   List lock = [
//     {
//       'Nilai': '1',
//       'QuestionType': '1',
//     },
//     {
//       'Nilai': '2',
//       'QuestionType': '2',
//     },
//     {
//       'Nilai': '3',
//       'QuestionType': '3',
//     },
//     {
//       'Nilai': '4',
//       'QuestionType': '4',
//     },
//     {
//       'Nilai': '5',
//       'QuestionType': '5',
//     },
//     {
//       'Nilai': '6',
//       'QuestionType': '6',
//     },
//     {
//       'Nilai': '7',
//       'QuestionType': '7',
//     },
//     {
//       'Nilai': '8',
//       'QuestionType': '8',
//     },
//     {
//       'Nilai': '9',
//       'QuestionType': '9',
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//             padding: const EdgeInsets.only(
//               top: 20.0,
//               left: 10,
//             ),
//             child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back, color: Colors.black),
//                 onPressed: () {
//                   Navigator.pop(
//                     context,
//                     // MaterialPageRoute(
//                     //  builder: (context) => SubSubjectPage(title: "")),
//                   );
//                 },
//               ),
//               Padding(
//                   padding: const EdgeInsets.only(
//                     top: 5.0,
//                   ),
//                   child: new Text('திரும்பிச் செல்',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 10.0,
//                       ))),
//             ])),
//         leadingWidth: width * 1,
//         titleSpacing: 0.00,
//         actions: [
//           Padding(
//               padding: const EdgeInsets.only(
//                 top: 30.0,
//                 right: 10,
//               ),
//               child: new Text('நிக்கி.',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16.0,
//                   ))),
//           Container(
//               margin: const EdgeInsets.only(right: 30.0, top: 10.0),
//               child: GestureDetector(
//                 onTap: () {},
//                 child: new SvgPicture.asset(
//                   'assets/svg/Group 86.svg',
//                   width: 50.0,
//                   height: 50.0,
//                   allowDrawingOutsideViewBox: true,
//                 ),
//               )),
//         ],
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//           child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//                       child: Text(
//                         "கற்றல் செயற்பாடுகள்",
//                         style: GoogleFonts.muktaMalar(
//                           fontSize: 20,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       )),
//                   GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 25.0,
//                         crossAxisSpacing: 25.0,
//                       ),
//                       itemCount: lock.length,
//                       itemBuilder: (BuildContext ctx, index) {
//                         return GestureDetector(
//                             onTap: () {
//                               if (lock[index]['Nilai'] == "1") {
//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) =>
//                                 //           Quiz1Page(title: '')),
//                                 // );
//                               } else if (lock[index]['Nilai'] == "2") {
//                                 if (widget.nilai >= 1) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Quiz2Page(title: '')),
//                                   );

//                                   //  _incrementCounter();
//                                 } else {
//                                   int xNilai =
//                                       int.parse(lock[index]['Nilai']) - 1;
//                                   int xNilai2 = int.parse(lock[index]['Nilai']);
//                                   popup(context, xNilai, xNilai2);
//                                 }

//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => QuizPage(title: '')),
//                                 // );

//                               } else if (lock[index]['Nilai'] == "3") {
//                                 if (widget.nilai >= 2) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Quiz3Page(title: '')),
//                                   );

//                                   //  _incrementCounter();
//                                 } else {
//                                   int xNilai =
//                                       int.parse(lock[index]['Nilai']) - 1;
//                                   int xNilai2 = int.parse(lock[index]['Nilai']);
//                                   popup(context, xNilai, xNilai2);
//                                 }
//                               } else if (lock[index]['Nilai'] == "4") {
//                                 if (widget.nilai >= 3) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Quiz4Page(title: '')),
//                                   );

//                                   //  _incrementCounter();
//                                 } else {
//                                   int xNilai =
//                                       int.parse(lock[index]['Nilai']) - 1;
//                                   int xNilai2 = int.parse(lock[index]['Nilai']);
//                                   popup(context, xNilai, xNilai2);
//                                 }
//                               } else if (lock[index]['Nilai'] == "5") {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           Quiz4Page(title: '')),
//                                 );
//                               } else {
//                                 return;
//                               }
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               child: int.parse(lock[index]['Nilai']) <=
//                                       widget.nilai
//                                   ? Stack(children: <Widget>[
//                                       Opacity(
//                                           opacity: 0.5,
//                                           child: Card(
//                                               color: kPrimaryLight2GreenColor,
//                                               child: Container(
//                                                 height: 150,
//                                                 width: 150,
//                                               ),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15.0),
//                                               ))),
//                                       SafeArea(
//                                           child: Align(
//                                               alignment: Alignment.center,
//                                               child: Text(
//                                                 lock[index]['Nilai'],
//                                                 style: GoogleFonts.muktaMalar(
//                                                   fontSize: 40,
//                                                   color: Colors.white,
//                                                 ),
//                                               ))),
//                                       SafeArea(
//                                           child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Align(
//                                                   alignment:
//                                                       Alignment.bottomRight,
//                                                   child: Container(
//                                                       height: 25.0,
//                                                       width: 25.0,
//                                                       decoration: BoxDecoration(
//                                                           image:
//                                                               DecorationImage(
//                                                         image: AssetImage(
//                                                           'assets/png/Unlocked.png',
//                                                         ),
//                                                         fit: BoxFit.contain,
//                                                       ))))))
//                                     ])
//                                   : Stack(children: <Widget>[
//                                       SafeArea(
//                                           child: Align(
//                                               alignment: Alignment.center,
//                                               child: int.parse(lock[index]
//                                                           ['Nilai']) ==
//                                                       widget.nilai
//                                                   ? Text(
//                                                       lock[index]['Nilai'],
//                                                       style: GoogleFonts
//                                                           .muktaMalar(
//                                                         fontSize: 40,
//                                                         color: Colors.white,
//                                                       ),
//                                                     )
//                                                   : Text(lock[index]['Nilai'],
//                                                       style: GoogleFonts
//                                                           .muktaMalar(
//                                                         fontSize: 40,
//                                                         color: Colors.black,
//                                                       )))),
//                                       SafeArea(
//                                           child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Align(
//                                                   alignment:
//                                                       Alignment.bottomRight,
//                                                   child: int.parse(lock[index]
//                                                                   ['Nilai']) ==
//                                                               1 ||
//                                                           int.parse(lock[index]
//                                                                   ['Nilai']) ==
//                                                               widget.next_nilai
//                                                       ? Container(
//                                                           height: 25.0,
//                                                           width: 25.0,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                                   image:
//                                                                       DecorationImage(
//                                                             image: AssetImage(
//                                                               'assets/png/Unlocked.png',
//                                                             ),
//                                                             fit: BoxFit.contain,
//                                                           )))
//                                                       : Container(
//                                                           height: 25.0,
//                                                           width: 25.0,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                                   image:
//                                                                       DecorationImage(
//                                                             image: AssetImage(
//                                                               'assets/png/locked.png',
//                                                             ),
//                                                             fit: BoxFit.contain,
//                                                           ))))))
//                                     ]),
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[300],
//                                   borderRadius: BorderRadius.circular(15)),
//                             ));
//                       }),
//                 ],
//               ))),
//     );
//   }

//   Future<dynamic> popup(BuildContext context, int xNilai, int xNilai2) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Padding(
//                 padding:
//                     const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Column(
//                     children: <Widget>[
//                       Text('நிலை $xNilai2 ஐ திறக்க நீங்கள்',
//                           style: GoogleFonts.muktaMalar(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           )),
//                       Text('நிலை $xNilai ஐ முடிக்க வேண்டும் ',
//                           style: GoogleFonts.muktaMalar(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           )),
//                       Padding(
//                           padding: const EdgeInsets.only(top: 15.0),
//                           child: ConstrainedBox(
//                             constraints:
//                                 BoxConstraints.tightFor(width: 130, height: 40),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => LockPage(
//                                             nilai: widget.nilai,
//                                             next_nilai: widget.next_nilai,
//                                           )),
//                                 );
//                               },
//                               child: Text(
//                                 'சரி',
//                                 style: GoogleFonts.muktaMalar(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 primary: kPrimaryRedColor,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: new BorderRadius.all(
//                                         new Radius.circular(20))),
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 )),
//           );
//         });
//   }
// }
