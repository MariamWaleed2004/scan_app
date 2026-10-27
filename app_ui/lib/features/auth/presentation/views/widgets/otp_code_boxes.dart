import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// Six code boxes; filled digits are white, the next empty one is outlined.
class OtpCodeBoxes extends StatelessWidget {
  final List<String> digits;
  const OtpCodeBoxes({super.key, required this.digits});

  @override
  Widget build(BuildContext context) {
    final filled = digits.where((d) => d.isNotEmpty).length;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      for (var i = 0; i < digits.length; i++)
        Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: i < filled ? Colors.white : AppColors.fieldBg,
              borderRadius: BorderRadius.circular(14),
              border: i == filled ? Border.all(color: AppColors.teal) : null),
          child: Text(digits[i], style: ts(22, w: FontWeight.w800, c: AppColors.teal)),
        ),
    ]);
  }
}
