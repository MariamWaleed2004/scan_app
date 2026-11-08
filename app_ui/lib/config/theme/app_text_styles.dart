import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// English text style (Outfit).
TextStyle ts(double s, {FontWeight w = FontWeight.w500, Color c = Colors.black87}) =>
    GoogleFonts.outfit(fontSize: s, fontWeight: w, color: c);

/// Arabic text style (Cairo).
TextStyle ar(double s, {Color c = Colors.black54}) =>
    GoogleFonts.cairo(fontSize: s, color: c);
