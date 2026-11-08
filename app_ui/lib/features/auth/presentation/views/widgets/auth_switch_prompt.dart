import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// "Already have an account? Log in" / "Don't have an account? Register".
class AuthSwitchPrompt extends StatelessWidget {
  final String question;
  final String action;
  final VoidCallback onTap;

  const AuthSwitchPrompt({super.key, required this.question, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onTap: onTap,
          child: Text.rich(TextSpan(text: '$question ', style: ts(14), children: [
            TextSpan(text: action, style: ts(14, w: FontWeight.w700, c: AppColors.brick)),
          ])),
        ),
      );
}
