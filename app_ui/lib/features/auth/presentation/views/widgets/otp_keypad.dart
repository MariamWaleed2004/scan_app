import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class OtpKeypad extends StatelessWidget {
  const OtpKeypad({super.key});

  static const _keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '☝', '0', '⌫'];

  @override
  Widget build(BuildContext context) => GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2.2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (final k in _keys)
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: k == '☝' ? Colors.transparent : AppColors.fieldBg,
                  borderRadius: BorderRadius.circular(14)),
              child: Text(k, style: ts(22, w: FontWeight.w700)),
            ),
        ],
      );
}
