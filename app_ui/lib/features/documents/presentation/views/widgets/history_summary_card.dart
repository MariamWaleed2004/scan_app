import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class HistorySummaryCard extends StatelessWidget {
  final int recordCount;
  final int projectCount;
  final double totalMb;

  const HistorySummaryCard({
    super.key,
    required this.recordCount,
    required this.projectCount,
    required this.totalMb,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(24)),
        child: Row(children: [
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$recordCount Archival Records', style: ts(21, w: FontWeight.w800, c: Colors.white)),
            const SizedBox(height: 4),
            Text('Synced across $projectCount projects • ${totalMb.toStringAsFixed(1)} MB total',
                style: ts(12, c: Colors.white70)),
          ])),
          const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white12,
              child: Icon(Icons.cloud_outlined, color: Colors.white70, size: 28)),
        ]),
      );
}
