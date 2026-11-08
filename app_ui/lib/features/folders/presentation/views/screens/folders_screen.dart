import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/widgets/empty_view.dart';
import 'package:fekra_house/core/widgets/error_view.dart';
import 'package:fekra_house/core/widgets/loading_indicator.dart';
import 'package:fekra_house/core/widgets/search_box.dart';
import '../../view_model/folders_cubit.dart';
import '../../view_model/folders_state.dart';
import '../widgets/cloud_sync_banner.dart';
import '../widgets/folder_card.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: BlocBuilder<FoldersCubit, FoldersState>(
          builder: (context, state) => switch (state.status) {
            FoldersStatus.loading => const LoadingIndicator(),
            FoldersStatus.failure => ErrorView(
                message: state.errorMessage ?? 'Could not load folders.',
                onRetry: context.read<FoldersCubit>().load,
              ),
            FoldersStatus.success || FoldersStatus.empty => _FoldersContent(state),
          },
        ),
      );
}

class _FoldersContent extends StatelessWidget {
  final FoldersState state;
  const _FoldersContent(this.state);

  Widget _chip(String t, {bool on = false, Color? c}) => Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
            color: on ? AppColors.teal : (c ?? AppColors.fieldBg), borderRadius: BorderRadius.circular(20)),
        child: Text(t,
            style: ts(13.5,
                w: FontWeight.w700, c: on ? Colors.white : (c != null ? AppColors.brick : Colors.black87))),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Folders', style: ts(32, w: FontWeight.w800, c: AppColors.teal)),
                  Text('${state.folders.length} active categories • ${state.totalFiles} files',
                      style: ts(12, c: Colors.black54)),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(22)),
                  child: Row(children: [
                    const Icon(Icons.create_new_folder_outlined, color: Colors.white),
                    const SizedBox(width: 6),
                    Text('New Folder', style: ts(15, w: FontWeight.w800, c: Colors.white)),
                  ]),
                ),
              ]),
          const SizedBox(height: 16),
          Row(children: [
            const Expanded(child: SearchBox('Search folders...')),
            const SizedBox(width: 10),
            Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black12)),
                child: const Icon(Icons.grid_view)),
            const SizedBox(width: 8),
            Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.view_list)),
          ]),
          const SizedBox(height: 14),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                _chip('All Folders  ${state.folders.length}', on: true),
                _chip('Recent'),
                _chip('Pinned'),
                _chip('Simulate Empty', c: AppColors.pink),
              ])),
          const SizedBox(height: 14),
          Expanded(
            child: state.folders.isEmpty
                ? const EmptyView(
                    icon: Icons.folder_open,
                    title: 'No folders yet',
                    message: 'Tap “New Folder” to start organizing your documents.',
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: .98,
                    children: [for (final f in state.folders) FolderCard(f)],
                  ),
          ),
          if (state.cloudUsage != null) CloudSyncBanner(state.cloudUsage!),
        ]),
      );
}
