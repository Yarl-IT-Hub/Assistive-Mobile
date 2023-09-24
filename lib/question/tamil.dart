import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assistive_app/api/api.dart';
import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/constants.dart';
import 'package:assistive_app/questionLock/Lock.dart';
import 'package:assistive_app/terms/termsCatergory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TamilPage extends StatefulWidget {
  TamilPage({Key? key, required this.title, required this.id})
      : super(key: key);

  final String title;
  final int id;

  @override
  _TamilPageState createState() => _TamilPageState();
}

class _TamilPageState extends State<TamilPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late int id;

  @override
  void initState() {
    //initialize grades id for terms
    id = widget.id;
    print(id);
    _getTermbyID();
    super.initState();
  }

//initialize list for add terms from API
  List _TermsFromDB = [];

  // loader
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //fetch image from api
    var image = "https://deafapi.moodfor.codes/images/";
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: BaseAppBar(
        bacKText: "திரும்பிச் செல்",
        appBar: AppBar(),
      ),
      body:  NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            // ignore: deprecated_member_use
            overscroll.disallowGlow();
            return false;
          },
          child:SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack(children: <Widget>[
            //   Padding(
            //     padding: const EdgeInsets.only(top: 20, left: 20, right: 20.0),
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20.0,
                top: 20,
              ),
              child: Container(
                child: !_isLoading
                    ? _TermsFromDB[0].length == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text("No terms available"),
                          )
                        : SizedBox(
                          height: MediaQuery.of(context).size.height*0.8,
                          child:
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: _TermsFromDB[0].length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Terms_Catergory(
                                            list: _TermsFromDB[0][index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        height: 120,
                                        child: Stack(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CachedNetworkImage(
                                                height: 200,
                                                // width: 160,
                                                imageUrl: image +
                                                    _TermsFromDB[0][index]
                                                        ['image'],
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.contain),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            )
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
                            },
                          ),
                        )
                    : Padding(
                        padding: const EdgeInsets.only(top: 120.0, left: 180),
                        child: CupertinoActivityIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  //get subjects details from api
  void _getTermbyID() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _TermsFromDB.clear();
      var bodyRoutes;
      var res = await CallApi().getTermsById("getTermByGradeId/${widget.id}");
      bodyRoutes = json.decode(res.body);

      // Add terms from body to _GradesFromDB List
      _TermsFromDB.add(bodyRoutes);
      print(_TermsFromDB[0]);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
