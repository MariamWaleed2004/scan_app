import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// Generic "nothing here yet" state.
class EmptyView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;

  const EmptyView({super.key, this.icon = Icons.inbox_outlined, required this.title, this.message});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.fieldBg,
              child: Icon(icon, color: AppColors.teal, size: 30),
            ),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, style: ts(16, w: FontWeight.w800, c: AppColors.teal)),
            if (message != null) ...[
              const SizedBox(height: 4),
              Text(message!, textAlign: TextAlign.center, style: ts(13, c: Colors.black54)),
            ],
          ]),
        ),
      );
}
