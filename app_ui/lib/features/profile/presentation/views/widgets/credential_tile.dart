import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/widgets/app_card.dart';

class CredentialTile extends StatelessWidget {
  final String label;
  final String value;
  const CredentialTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: AppCard(
          pad: const EdgeInsets.all(12),
          child: Row(children: [
            Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(12))),
            const SizedBox(width: 12),
            Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: ts(11.5, c: Colors.black54)),
              Text(value, style: ts(16, w: FontWeight.w800, c: Colors.black)),
            ])),
            const CircleAvatar(
                radius: 17,
                backgroundColor: AppColors.fieldBg,
                child: Icon(Icons.copy, size: 16, color: Colors.black54)),
          ]),
        ),
      );
}
