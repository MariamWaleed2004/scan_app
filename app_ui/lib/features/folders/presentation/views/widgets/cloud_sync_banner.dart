import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/features/documents/domain/entities/storage_usage.dart';

class CloudSyncBanner extends StatelessWidget {
  final StorageUsage usage;
  const CloudSyncBanner(this.usage, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(color: const Color(0xFFEFE9E5), borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          const CircleAvatar(
              backgroundColor: Colors.white, child: Icon(Icons.cloud_upload_outlined, color: AppColors.teal)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Synced with بيت الفكرة Cloud', style: ts(13.5, w: FontWeight.w800, c: Colors.black)),
            Text('${usage.usedGb} GB of ${usage.totalGb.toStringAsFixed(0)} GB utilized',
                style: ts(11.5, c: Colors.black54)),
          ])),
          const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.sync, color: AppColors.teal)),
        ]),
      );
}
