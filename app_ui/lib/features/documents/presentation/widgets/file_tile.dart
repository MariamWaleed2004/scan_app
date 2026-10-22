import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/core/widgets/app_card.dart';
import 'package:app_ui/core/widgets/folder_tag.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/document_file.dart';
import '../category_style.dart';

class FileTile extends StatelessWidget {
  final DocumentFile file;

  /// History mode: shows only the size as meta and the time on the right.
  final bool showTime;
  const FileTile(this.file, {super.key, this.showTime = false});

  @override
  Widget build(BuildContext context) {
    final meta = showTime ? file.sizeLabel : '${file.modifiedLabel} · ${file.sizeLabel}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        child: Row(children: [
          Container(
              width: 48, height: 60, alignment: Alignment.center,
              decoration: BoxDecoration(color: const Color(0xFFFBE5E1), borderRadius: BorderRadius.circular(10)),
              child: Text('PDF', style: ts(11, w: FontWeight.w700, c: AppColors.brick))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(file.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(14.5, w: FontWeight.w700)),
              const SizedBox(height: 4),
              FolderTag(file.category.title, file.category.tagColor),
              const SizedBox(height: 4),
              Text(meta, style: ts(12, c: Colors.black54)),
            ]),
          ),
          Column(children: [
            const Icon(Icons.more_vert, size: 20, color: Colors.black45),
            if (showTime && file.timeLabel.isNotEmpty) Text(file.timeLabel, style: ts(12, c: Colors.black54)),
          ]),
        ]),
      ),
    );
  }
}
