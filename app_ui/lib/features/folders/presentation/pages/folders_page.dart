import 'package:app_ui/core/di/injector.dart';
import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/core/usecase/usecase.dart';
import 'package:app_ui/core/widgets/future_view.dart';
import 'package:app_ui/core/widgets/search_box.dart';
import 'package:app_ui/features/documents/domain/entities/storage_usage.dart';
import 'package:app_ui/features/documents/presentation/category_style.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/folder_entity.dart';

typedef _FoldersData = ({List<FolderEntity> folders, StorageUsage cloud});

class FoldersPage extends StatelessWidget {
  const FoldersPage({super.key});

  Future<_FoldersData> _load() async {
  final List<FolderEntity> folders =
      await Injector.getFolders(const NoParams());

  final StorageUsage cloud =
      await Injector.getCloudUsage(const NoParams());

  return (
    folders: folders,
    cloud: cloud,
  );
}

  Widget _chip(String t, {bool on = false, Color? c}) => Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(color: on ? AppColors.teal : (c ?? AppColors.fieldBg), borderRadius: BorderRadius.circular(20)),
        child: Text(t, style: ts(13.5, w: FontWeight.w700, c: on ? Colors.white : (c != null ? AppColors.brick : Colors.black87))),
      );

  Widget _folder(FolderEntity f) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: f.category.folderBg, borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.folder_outlined, color: f.category.folderFg)),
            const Icon(Icons.more_vert, size: 18, color: Colors.black45),
          ]),
          const Spacer(),
          Text(f.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(15, w: FontWeight.w800, c: Colors.black)),
          Text(f.meta, style: ts(11.5, c: Colors.black54)),
        ]),
      );

  Widget _cloudBanner(StorageUsage cloud) => Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(color: const Color(0xFFEFE9E5), borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.cloud_upload_outlined, color: AppColors.teal)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Synced with بيت الفكرة Cloud', style: ts(13.5, w: FontWeight.w800, c: Colors.black)),
            Text('${cloud.usedGb} GB of ${cloud.totalGb.toStringAsFixed(0)} GB utilized', style: ts(11.5, c: Colors.black54)),
          ])),
          const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.sync, color: AppColors.teal)),
        ]),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureView<_FoldersData>(
          load: _load,
          builder: (context, d) {
            final totalFiles = d.folders.fold<int>(0, (s, f) => s + f.fileCount);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Folders', style: ts(32, w: FontWeight.w800, c: AppColors.teal)),
                    Text('${d.folders.length} active categories • $totalFiles files', style: ts(12, c: Colors.black54)),
                  ]),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(22)),
                    child: Row(children: [
                      const Icon(Icons.create_new_folder_outlined, color: Colors.white), const SizedBox(width: 6),
                      Text('New Folder', style: ts(15, w: FontWeight.w800, c: Colors.white)),
                    ]),
                  ),
                ]),
                const SizedBox(height: 16),
                Row(children: [
                   Expanded(child: SearchBox('Search folders...')),
                  const SizedBox(width: 10),
                  Container(padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.black12)),
                      child: const Icon(Icons.grid_view)),
                  const SizedBox(width: 8),
                  Container(padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(14)),
                      child: const Icon(Icons.view_list)),
                ]),
                const SizedBox(height: 14),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      _chip('All Folders  ${d.folders.length}', on: true),
                      _chip('Recent'), _chip('Pinned'), _chip('Simulate Empty', c: AppColors.pink),
                    ])),
                const SizedBox(height: 14),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: .98,
                    children: [for (final f in d.folders) _folder(f)],
                  ),
                ),
                _cloudBanner(d.cloud),
              ]),
            );
          },
        ),
      );
}
