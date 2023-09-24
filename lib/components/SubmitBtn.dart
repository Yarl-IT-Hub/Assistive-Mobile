import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SubmitBtn extends StatelessWidget {
  final VoidCallback function;
  const SubmitBtn({
    Key? key, required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: width * 1, height: 60),
        child: ElevatedButton(
          onPressed: function,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('முடிக்கவும்',
                  style: GoogleFonts.muktaMalar(
                    fontSize: 24,
                    color: Colors.white,
                  )),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: kPrimaryRedColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
          ),
        ),
      ),
    );
  }
}
