import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color background;
  final Color foreground;
  final IconData icon;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.background,
    required this.foreground,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 118,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: foreground, size: 28)),
          const Spacer(),
          Text(title, style: ts(16, w: FontWeight.w800, c: foreground)),
          Text(subtitle, style: ts(11, c: foreground)),
        ]),
      );
}
