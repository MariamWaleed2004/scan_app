import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/widgets/app_card.dart';
import 'package:fekra_house/features/documents/domain/entities/storage_usage.dart';

class VaultStorageCard extends StatelessWidget {
  final StorageUsage usage;
  const VaultStorageCard(this.usage, {super.key});

  @override
  Widget build(BuildContext context) => AppCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Vault Storage', style: ts(14, w: FontWeight.w800, c: AppColors.teal)),
            Text(usage.label, style: ts(12, c: Colors.black54)),
          ]),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Row(children: [
              Expanded(flex: 5, child: Container(height: 8, color: AppColors.teal)),
              Expanded(flex: 3, child: Container(height: 8, color: AppColors.coral)),
              Expanded(flex: 2, child: Container(height: 8, color: AppColors.olive)),
              Expanded(flex: 1, child: Container(height: 8, color: Colors.black12)),
            ]),
          ),
        ]),
      );
}
