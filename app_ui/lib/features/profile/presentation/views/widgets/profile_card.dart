import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/widgets/app_card.dart';
import 'package:fekra_house/core/widgets/gradient_button.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';

class ProfileCard extends StatelessWidget {
  final User user;
  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) => AppCard(
        pad: const EdgeInsets.all(14),
        child: Column(children: [
          Stack(clipBehavior: Clip.none, children: [
            Container(
              width: 78,
              height: 78,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.coral, width: 4)),
              child: Text(user.initials, style: ts(26, w: FontWeight.w800, c: AppColors.teal)),
            ),
            Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle))),
          ]),
          const SizedBox(height: 10),
          Text(user.fullName, style: ts(21, w: FontWeight.w800, c: Colors.black)),
          Text('Bilingual Workspace Member', style: ts(12, c: Colors.black54)),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Text(user.title, style: ts(16, c: AppColors.teal)),
              Text('Tap to edit title', style: ts(10.5, c: Colors.black45)),
            ]),
          ),
          const SizedBox(height: 10),
          const GradientButton('Save changes', colors: [AppColors.coral, AppColors.coral]),
        ]),
      );
}
