import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/core/widgets/logo.dart';

/// Back button · logo · language button.
class AuthTopBar extends StatelessWidget {
  const AuthTopBar({super.key});

  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CircleAvatar(
          backgroundColor: AppColors.fieldBg,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.teal, size: 20),
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
        const Logo(size: .4),
        const CircleAvatar(backgroundColor: AppColors.fieldBg, child: Icon(Icons.language, color: AppColors.teal)),
      ]);
}
