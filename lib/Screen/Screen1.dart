import 'package:assistive_app/Screen/screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  _Scrren1State createState() => _Scrren1State();
}

class _Scrren1State extends State<Screen1> {
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
                "assets/png/vecteezy_education-children-illustration-background_AW0321_generated.png",
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
                    padding: const EdgeInsets.only(top: 0
                        // bottom: 150,
                        ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: screenWidth * 1.0, height: 75),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Screen2()),
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
