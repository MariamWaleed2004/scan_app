import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class ResendCodeCard extends StatelessWidget {
  final String countdown;
  const ResendCodeCard({super.key, this.countdown = '00:30'});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          const CircleAvatar(radius: 18, backgroundColor: AppColors.blueTag),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Resend code in', style: ts(11)),
            Text(countdown, style: ts(18, w: FontWeight.w800)),
          ]),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(14)),
            child: Text('Resend SMS', style: ts(13, w: FontWeight.w700, c: Colors.black38)),
          ),
        ]),
      );
}
