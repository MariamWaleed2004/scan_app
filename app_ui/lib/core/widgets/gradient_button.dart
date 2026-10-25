import 'package:flutter/material.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final VoidCallback? onTap;
  const GradientButton(this.text, {super.key, required this.colors, this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors), borderRadius: BorderRadius.circular(18)),
          child: Text(text, style: ts(18, w: FontWeight.w700, c: Colors.white)),
        ),
      );
}
