import 'dart:convert';
import 'package:assistive_app/components/subjectappbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assistive_app/Subject/subSubject.dart';
import 'package:assistive_app/Subject/subject.dart';
import 'package:assistive_app/api/api.dart';
import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GradePage extends StatefulWidget {
  final int idForGetSubjects;
  const GradePage({key, required this.idForGetSubjects}) : super(key: key);

  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late int idForGetSubjects;

  //initialize list for add grades from API
  List _GradesFromDB = [];

  @override
  void initState() {
    //initialize subject id for grades
    idForGetSubjects = widget.idForGetSubjects;
    print(idForGetSubjects);
    _getGradebyID();

    super.initState();
  }

  // loader
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //fetch image from api
    var image = "https://deafapi.moodfor.codes/images/";
    return Scaffold(
      key: _scaffoldKey,
      appBar: SubjectBaseAppBar(
        bacKText: "திரும்பிச் செல்",
        appBar: AppBar(),
      ),
      body: Container(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(top: 10.0),
            //         child: TextField(
            //           decoration: InputDecoration(
            //             border: InputBorder.none,
            //             fillColor: kPrimaryGreyColor,
            //             prefixIcon: Padding(
            //                 padding:
            //                     const EdgeInsets.only(left: 20, right: 20.0),
            //                 child: Icon(
            //                   Icons.search,
            //                   color: Colors.grey,
            //                 )),
            //             suffixIcon: Padding(
            //                 padding: const EdgeInsets.only(right: 20.0),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: <Widget>[
            //                     Container(
            //                         height: 30,
            //                         width: 40,
            //                         child: VerticalDivider(
            //                           color: Colors.grey,
            //                           thickness: 1,
            //                         )),
            //                     Icon(
            //                       Icons.keyboard_arrow_down,
            //                       color: Colors.black,
            //                     )
            //                   ],
            //                 )),
            //             enabledBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(15.0),
            //               ),
            //               borderSide: BorderSide(
            //                 color: Colors.white,
            //                 width: 2,
            //               ),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(15.0),
            //               ),
            //               borderSide: BorderSide(
            //                 color: kPrimaryGreyColor,
            //                 width: 2,
            //               ),
            //             ),
            //             contentPadding: EdgeInsets.all(25.0),
            //             filled: true,
            //             hintText: 'தேடு',
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            !_isLoading
                ? _GradesFromDB.length == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text("No Grades available"),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 120.0, horizontal: 20),
                          //list
                          child: ListView.builder(
                            itemCount: _GradesFromDB[0].length,
                            itemBuilder: (context, index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 40),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print(_GradesFromDB[0][index]);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SubSubjectPage(
                                                      idForGetTerms:
                                                          _GradesFromDB[0]
                                                              [index]['id'],
                                                      noOfLevels:
                                                          _GradesFromDB[0]
                                                                  [index]
                                                              ['no_of_levels'],
                                                      title: "",
                                                      subjectId:
                                                          idForGetSubjects,
                                                    )));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: CachedNetworkImage(
                                          height: 100,
                                          // width: 160,
                                          imageUrl: image +
                                              _GradesFromDB[0][index]['image'],
                                          imageBuilder:
                                              (context, imageProvider) =>
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
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ]);
                            },
                          ),
                        ),
                      )
                : Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
          ],
        ),
      ),
    );
  }

//get subjects details from api
  void _getGradebyID() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _GradesFromDB.clear();
      var bodyRoutes;
      var res = await CallApi()
          .getSubjectById("getGradeBySubjectId/${widget.idForGetSubjects}");
      bodyRoutes = json.decode(res.body);

      // Add grades from body to _GradesFromDB List
      print(bodyRoutes);
      if (bodyRoutes['errorMessage'] == true) {
        _GradesFromDB.add(bodyRoutes['data']);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
