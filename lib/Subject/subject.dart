import 'dart:convert';

import 'package:assistive_app/Login/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assistive_app/_helper/sharedPreference.dart';
import 'package:assistive_app/api/api.dart';
import 'package:assistive_app/constants.dart';
import 'package:assistive_app/grade/grade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectPage extends StatefulWidget {
  SubjectPage({Key? key}) : super(key: key);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userName = "";

  List _SubjectsFromDB = [];

// loader
  bool _isLoading = true;

  @override
  initState() {
    _apiGetSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //fetch image from api
    var image = "https://deafapi.moodfor.codes/images/";
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                // IconButton(
                //   icon: Icon(Icons.subject, color: Colors.black),
                //   onPressed: () {},
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                  ),
                ),
              ])),
          leadingWidth: width * 1,
          titleSpacing: 0.00,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                right: 10,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 30.0, top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    openDialog(context);
                  },
                  child: new SvgPicture.asset(
                    'assets/svg/Group 86.svg',
                    width: 50.0,
                    height: 50.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                )),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'வணக்கம் ',
                    style: GoogleFonts.muktaMalar(
                      fontSize: 15,
                    ),
                  )),
              new Text('${userName}.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)),
            ]),
            // Stack(children: <Widget>[
            //   Padding(
            //     padding: const EdgeInsets.only(left: 20, right: 20.0),
            //     child: Column(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(top: 10.0),
            //           child: TextField(
            //             decoration: InputDecoration(
            //               border: InputBorder.none,
            //               fillColor: kPrimaryGreyColor,
            //               prefixIcon: Padding(
            //                   padding:
            //                       const EdgeInsets.only(left: 20, right: 20.0),
            //                   child: Icon(
            //                     Icons.search,
            //                     color: Colors.grey,
            //                   )),
            //               suffixIcon: Padding(
            //                   padding: const EdgeInsets.only(right: 20.0),
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: <Widget>[
            //                       Container(
            //                           height: 30,
            //                           width: 40,
            //                           child: VerticalDivider(
            //                             color: Colors.grey,
            //                             thickness: 1,
            //                           )),
            //                       Icon(
            //                         Icons.keyboard_arrow_down,
            //                         color: Colors.black,
            //                       )
            //                     ],
            //                   )),
            //               enabledBorder: OutlineInputBorder(
            //                 borderRadius: BorderRadius.all(
            //                   Radius.circular(15.0),
            //                 ),
            //                 borderSide: BorderSide(
            //                   color: Colors.white,
            //                   width: 2,
            //                 ),
            //               ),
            //               focusedBorder: OutlineInputBorder(
            //                 borderRadius: BorderRadius.all(
            //                   Radius.circular(15.0),
            //                 ),
            //                 borderSide: BorderSide(
            //                   color: kPrimaryGreyColor,
            //                   width: 2,
            //                 ),
            //               ),
            //               contentPadding: EdgeInsets.all(25.0),
            //               filled: true,
            //               hintText: 'தேடு',
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ]),
            // Padding(
            //     padding: const EdgeInsets.only(
            //       left: 20,
            //       right: 20,
            //     ),
            //     child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           GestureDetector(
            //             onTap: () {},
            //             child: Text(
            //               'வகைகள்  ',
            //               style: GoogleFonts.muktaMalar(
            //                   fontSize: 18, color: Colors.grey),
            //             ),
            //           ),
            //           GestureDetector(
            //             onTap: () {},
            //             child: Text(
            //               'அனைத்தையும் காட்டு',
            //               style: GoogleFonts.muktaMalar(
            //                   fontSize: 18, color: Colors.grey),
            //             ),
            //           ),
            //         ])),
            _isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 190),
                    child: CupertinoActivityIndicator(),
                  )
                : GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: _SubjectsFromDB[0].length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GradePage(
                                idForGetSubjects: _SubjectsFromDB[0][index]
                                    ['id']),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_SubjectsFromDB[0][index]['title'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.0)),
                              ),
                            ),
                            Expanded(
                              child: CachedNetworkImage(
                                // height: 150,
                                // width: 160,
                                imageUrl:
                                    image + _SubjectsFromDB[0][index]['image'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ]),
        ));
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "இப்போது வெளியேற வேண்டுமா?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryRedColor),
                    ),
                    Text("வெளியேற, இங்கே கிளிக் செய்யவும்.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        )),
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryRedColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: Text(
                          "வெளியேறு",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () async {
                          try {
                            MySharedPreferences.instance.removeAll();

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );

//get subjects details from api
  void _apiGetSubjects() async {
    userName = await MySharedPreferences.instance.getStringValue("userName");

    try {
      _SubjectsFromDB.clear();
      var bodyRoutes;
      var res = await CallApi().getAllSubjects('subjects');
      bodyRoutes = json.decode(res.body);

      // Add subjects to _SubjectsFromDB List
      _SubjectsFromDB.add(bodyRoutes);
      print(_SubjectsFromDB[0]);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
