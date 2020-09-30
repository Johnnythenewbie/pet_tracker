import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData primaryTheme = ThemeData(
    primaryColor: Color(0xFFB6C6FF),
    textTheme: GoogleFonts.poppinsTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
