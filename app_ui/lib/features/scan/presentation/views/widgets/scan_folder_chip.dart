import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';

/// "Folders / <target folder>  Change" pill with a folder dropdown.
class ScanFolderChip extends StatelessWidget {
  final FolderCategory category;
  final ValueChanged<FolderCategory> onChanged;

  const ScanFolderChip({super.key, required this.category, required this.onChanged});

  @override
  Widget build(BuildContext context) => PopupMenuButton<FolderCategory>(
        initialValue: category,
        onSelected: onChanged,
        tooltip: 'Choose folder',
        position: PopupMenuPosition.under,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        itemBuilder: (_) => [
          for (final c in FolderCategory.values)
            PopupMenuItem<FolderCategory>(value: c, child: Text(c.title, style: ts(14))),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(24)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.folder_outlined, color: AppColors.coral, size: 18),
            const SizedBox(width: 6),
            Text('Folders / ', style: ts(13, c: Colors.white70)),
            Flexible(
              child: Text(category.title,
                  overflow: TextOverflow.ellipsis, style: ts(14, w: FontWeight.w800, c: Colors.white)),
            ),
            const SizedBox(width: 10),
            Text('Change', style: ts(13, w: FontWeight.w800, c: AppColors.coral)),
          ]),
        ),
      );
}
