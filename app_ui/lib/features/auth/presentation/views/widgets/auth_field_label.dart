import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// Bilingual field label: English on the left, Arabic on the right.
class AuthFieldLabel extends StatelessWidget {
  final String english;
  final String arabic;
  const AuthFieldLabel(this.english, this.arabic, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(english, style: ts(14, w: FontWeight.w700, c: AppColors.teal)),
          Text(arabic, style: ar(13)),
        ]),
      );
}
