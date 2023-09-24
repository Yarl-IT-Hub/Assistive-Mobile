import 'package:assistive_app/_helper/controller.dart';
import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/constants.dart';
import 'package:assistive_app/questionLock/Lock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class StageFail extends StatefulWidget {
  StageFail(
      {Key? key,
      required this.totalQuestion,
      required this.correctAnswers,
      required this.successPercent})
      : super(key: key);

  final int totalQuestion;
  final int correctAnswers;
  final double successPercent;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<StageFail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MarksServices marksServices = MarksServices();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: BaseAppBar(
          bacKText: "திரும்பிச் செல்",
          appBar: AppBar(),
        ),
        body: Stack(children: [
          Center(
              child: new Form(
                  child: new Column(children: <Widget>[
            // SizedBox(height: screenHeight * (1 / 20)),
            Container(
              child: new Image.asset(
                "assets/png/Screenshot 2021-08-20 at 11.36.50 AM.png",
              ),
            ),
            SizedBox(height: screenHeight * (1 / 20)),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "நீங்கள் குறைந்தது ${widget.totalQuestion} இல் ${widget.totalQuestion ~/ 2} க்கு (50%) சரியாக  பதில் அளிக்க வேண்டும்",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "நீங்கள்  ${widget.totalQuestion} இல் ${widget.correctAnswers} க்கு (${widget.successPercent}%) சரியாக ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Container(
              child: Text(
                "  பதில் அளித்துள்ளீர்கள் ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: screenHeight * (1 / 20)),
            SizedBox.fromSize(
              size: Size(76, 76),
              child: ClipOval(
                child: Material(
                  color: Colors.redAccent[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.sync_rounded),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * (0.5 / 20)),
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
                          marksServices.deleteAllLocalStorage();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'மீண்டும் முயற்சி செய் ',
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
                    ))),
          )
        ]));
  }
}
