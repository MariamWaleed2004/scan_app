import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class ScanTipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color accent;
  const ScanTipCard({super.key, required this.title, required this.subtitle, required this.accent});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        height: 130,
        decoration: BoxDecoration(color: const Color(0xFFF1EBE7), borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: 44, height: 44, decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(12))),
          const Spacer(),
          Text(title, style: ts(14, w: FontWeight.w800, c: Colors.black)),
          Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(11, c: Colors.black54)),
        ]),
      );
}
