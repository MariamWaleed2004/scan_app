import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/features/documents/domain/entities/project_summary.dart';

class FeaturedProjectCard extends StatelessWidget {
  final ProjectSummary project;
  const FeaturedProjectCard(this.project, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: const Color(0xFFF1E6E3), borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8))),
          const SizedBox(width: 14),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(project.name, style: ts(14.5, w: FontWeight.w800, c: Colors.black)),
            Text('${project.blueprintCount} blueprints • Synced ${project.syncedLabel}',
                style: ts(11.5, c: Colors.black54)),
          ])),
          for (final (i, m) in project.memberInitials.indexed) ...[
            CircleAvatar(
                radius: 15,
                backgroundColor: i.isEven ? AppColors.blueTag : AppColors.pink,
                child: Text(m, style: const TextStyle(fontSize: 12))),
            const SizedBox(width: 4),
          ],
        ]),
      );
}
