import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/components/gradeappbar.dart';
import 'package:assistive_app/constants.dart';
import 'package:assistive_app/grade/grade.dart';
import 'package:assistive_app/question/tamil.dart';
import 'package:assistive_app/questionLock/Lock.dart';
import 'package:assistive_app/questionLock/QuestionLock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SubSubjectPage extends StatefulWidget {
  SubSubjectPage(
      {Key? key,
      required this.title,
      required this.idForGetTerms,
      required this.noOfLevels,
      required this.subjectId})
      : super(key: key);

  final String title;
  final int idForGetTerms;
  final int noOfLevels;
  final int subjectId;

  @override
  _SubSubjectPageState createState() => _SubSubjectPageState();
}

class _SubSubjectPageState extends State<SubSubjectPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Color> colors = <Color>[
    Colors.deepPurpleAccent,
    Colors.deepOrangeAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.pinkAccent
  ];
  final List<Map> details = [
    {'img': 'assets/png/1.png', "name": 'கலைச்சொற்கள்'},
    {'img': 'assets/png/2.png', "name": 'கற்றல் செயற்பாடுகள்'},
  ];
  late int idForGetTerms;
  late int noOfLevels;

  @override
  void initState() {
    //initialize subject id for grades
    idForGetTerms = widget.idForGetTerms;
    print(idForGetTerms);

    noOfLevels = widget.noOfLevels;
    print(noOfLevels);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: GradeBaseAppBar(
        bacKText: "திரும்பிச் செல்",
        appBar: AppBar(),
        subjectId: widget.subjectId,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20.0),
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       fillColor: kPrimaryGreyColor,
                  //       prefixIcon: Padding(
                  //           padding:
                  //               const EdgeInsets.only(left: 20, right: 20.0),
                  //           child: Icon(
                  //             Icons.search,
                  //             color: Colors.grey,
                  //           )),
                  //       suffixIcon: Padding(
                  //           padding: const EdgeInsets.only(right: 20.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: <Widget>[
                  //               Container(
                  //                   height: 30,
                  //                   width: 40,
                  //                   child: VerticalDivider(
                  //                     color: Colors.grey,
                  //                     thickness: 1,
                  //                   )),
                  //               Icon(
                  //                 Icons.keyboard_arrow_down,
                  //                 color: Colors.black,
                  //               )
                  //             ],
                  //           )),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(15.0),
                  //         ),
                  //         borderSide: BorderSide(
                  //           color: Colors.white,
                  //           width: 2,
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(15.0),
                  //         ),
                  //         borderSide: BorderSide(
                  //           color: kPrimaryGreyColor,
                  //           width: 2,
                  //         ),
                  //       ),
                  //       contentPadding: EdgeInsets.all(25.0),
                  //       filled: true,
                  //       hintText: 'தேடு',
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20.0,
                top: 20,
              ),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: details.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 270,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            details[index]['img'],
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          height: 70, width: width * 0.9),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (details[index]['name'] ==
                                                    "கலைச்சொற்கள்") {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TamilPage(
                                                                title: '',
                                                                id: widget
                                                                    .idForGetTerms)),
                                                  );
                                                } else if (details[index]
                                                        ['name'] ==
                                                    "கற்றல் செயற்பாடுகள்") {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuestionLockPage(
                                                                gradeid: widget
                                                                    .idForGetTerms,
                                                                level: widget
                                                                    .noOfLevels,
                                                                subjectId: widget
                                                                    .subjectId)),
                                                  );
                                                } else {
                                                  return;
                                                }
                                              },
                                              child: Text(
                                                  details[index]['name'],
                                                  style: GoogleFonts.muktaMalar(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                if (details[index]['name'] ==
                                                    "கலைச்சொற்கள்") {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TamilPage(
                                                                title: '',
                                                                id: widget
                                                                    .idForGetTerms)),
                                                  );
                                                } else if (details[index]
                                                        ['name'] ==
                                                    "கற்றல் செயற்பாடுகள்") {
                                                      print("-------------");
                                                      print(widget.idForGetTerms);
                                                      print(widget.noOfLevels);
                                                      print(widget.subjectId);
                                                      print("-------------");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuestionLockPage(
                                                              gradeid: widget
                                                                  .idForGetTerms,
                                                              level: widget
                                                                  .noOfLevels,
                                                              subjectId: widget
                                                                  .subjectId,
                                                            )),
                                                  );
                                                } else {
                                                  return;
                                                }
                                              },
                                              child: Icon(Icons.arrow_forward,
                                                  color: Colors.white),
                                              style: ElevatedButton.styleFrom(
                                                primary: kPrimaryRedColor,
                                                onPrimary: Colors.white,
                                                shape: CircleBorder(),
                                                padding: EdgeInsets.all(5),
                                                side: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: kPrimaryRedColor,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
