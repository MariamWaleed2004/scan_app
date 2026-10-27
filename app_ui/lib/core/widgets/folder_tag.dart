import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class FolderTag extends StatelessWidget {
  final String text;
  final Color color;
  const FolderTag(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.folder_outlined, size: 13, color: Colors.black54),
          const SizedBox(width: 4),
          Text(text, style: ts(11, w: FontWeight.w600, c: Colors.black87)),
        ]),
      );
}
