import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.outfitTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.coral),
      );
}
