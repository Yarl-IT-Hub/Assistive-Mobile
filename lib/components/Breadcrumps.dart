import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Breadcrumbs extends StatelessWidget {
  final String title;
  const Breadcrumbs({
    Key? key, required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        // color: Colors.grey,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Text(
          title,
          style: GoogleFonts.muktaMalar(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}