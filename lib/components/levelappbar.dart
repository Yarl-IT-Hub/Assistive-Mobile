import 'package:assistive_app/Subject/subSubject.dart';
import 'package:assistive_app/Subject/subject.dart';
import 'package:assistive_app/_helper/sharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuestionsBaseAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String bacKText;
  final AppBar? appBar;
  final int gradeid;
  final int subjectId;
  final List<Widget>? widgets;

  /// you can add more fields that meet your needs

  const QuestionsBaseAppBar(
      {Key? key,
      required this.bacKText,
      this.appBar,
      required this.gradeid,
      required this.subjectId,
      this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      title: Text(
        bacKText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      leadingWidth: 30,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubSubjectPage(
                              idForGetTerms: gradeid,
                              noOfLevels: 4,
                              title: "",
                              subjectId: subjectId,
                            )));
              },
            ),
          ),
          // Expanded(
          //   child: Text(
          //     bacKText,
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 16.0,
          //     ),
          //   ),
          // ),
        ],
      ),
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: UserName(),
            ),
            Container(
              margin: const EdgeInsets.only(right: 30.0, top: 0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SubjectPage()));
                },
                child: new SvgPicture.asset(
                  'assets/svg/Group 86.svg',
                  width: 40.0,
                  height: 40.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar!.preferredSize.height);
}

class UserName extends StatefulWidget {
  const UserName({
    Key? key,
  }) : super(key: key);

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  String? userName;
  bool loader = false;

  getUserName() async {
    setState(() {
      loader = true;
    });
    userName = await MySharedPreferences.instance.getStringValue("userName");
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      loader ? "" : "${userName}",
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    );
  }
}
