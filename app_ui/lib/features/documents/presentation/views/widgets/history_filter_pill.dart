import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class HistoryFilterPill extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color background;
  final Color foreground;

  const HistoryFilterPill({
    super.key,
    required this.icon,
    required this.text,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(22)),
        child: Row(children: [
          Icon(icon, size: 16, color: foreground),
          const SizedBox(width: 6),
          Expanded(
              child: Text(text,
                  overflow: TextOverflow.ellipsis, style: ts(13.5, w: FontWeight.w700, c: foreground))),
          Icon(Icons.keyboard_arrow_down, size: 16, color: foreground),
        ]),
      );
}
