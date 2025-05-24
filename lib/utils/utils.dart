import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  static TextStyle syneTextStyle = GoogleFonts.syne(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
  static TextStyle syneBoldTextStyle = GoogleFonts.syne(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle syneItalicTextStyle = GoogleFonts.lobster(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );
  static TextStyle syneBoldItalicTextStyle = GoogleFonts.lobster(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  static LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xffA90140), Color(0xff550120)],

    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
