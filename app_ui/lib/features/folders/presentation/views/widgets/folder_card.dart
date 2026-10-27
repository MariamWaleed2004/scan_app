import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/features/documents/presentation/views/widgets/category_style.dart';
import '../../../domain/entities/folder.dart';

class FolderCard extends StatelessWidget {
  final Folder folder;
  const FolderCard(this.folder, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 10)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: folder.category.folderBg, borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.folder_outlined, color: folder.category.folderFg)),
            const Icon(Icons.more_vert, size: 18, color: Colors.black45),
          ]),
          const Spacer(),
          Text(folder.name,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(15, w: FontWeight.w800, c: Colors.black)),
          Text(folder.meta, style: ts(11.5, c: Colors.black54)),
        ]),
      );
}
