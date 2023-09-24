import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class NextBeforeBtn extends StatelessWidget {
  final String text;
  final VoidCallback function;
  const NextBeforeBtn({
    Key? key, required this.text, required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints.tightFor(width: 130, height: 40),
      child: ElevatedButton(
        onPressed: function,
        child: Text(
          text,
          style: GoogleFonts.muktaMalar(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: kPrimaryRedColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.all(
                  new Radius.circular(20))),
        ),
      ),
    );
  }
}