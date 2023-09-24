import 'package:assistive_app/Subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Center(
              child: new Form(
                  child: new Column(children: <Widget>[
            SizedBox(height: screenHeight * (2 / 20)),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'நீங்கள் தயாரா ?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: kPrimaryDarkColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: screenHeight * (2 / 20)),
            Container(
              height: screenHeight * (8.5 / 20),
              child: new Image.asset(
                "assets/png/Vecteezy_Education_Childern2_bv0321_generated.png",
              ),
            ),
            SizedBox(height: screenHeight * (2 / 20)),
            Container(
              child: SvgPicture.asset(
                "assets/images/arrow.svg",
              ),
            ),
          ]))),
          SafeArea(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: screenWidth * 1.0, height: 75),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubjectPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'தொடக்கு',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      //   ),
                    ))),
          )
        ]));
  }
}
