import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/widgets/empty_view.dart';
import 'package:fekra_house/core/widgets/error_view.dart';
import 'package:fekra_house/core/widgets/loading_indicator.dart';
import 'package:fekra_house/core/widgets/logo.dart';
import '../../view_model/history_cubit.dart';
import '../../view_model/history_state.dart';
import '../widgets/file_tile.dart';
import '../widgets/history_filter_pill.dart';
import '../widgets/history_summary_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) => switch (state.status) {
            HistoryStatus.loading => const LoadingIndicator(),
            HistoryStatus.failure => ErrorView(
                message: state.errorMessage ?? 'Could not load history.',
                onRetry: context.read<HistoryCubit>().load,
              ),
            HistoryStatus.success || HistoryStatus.empty => _HistoryContent(state),
          },
        ),
      );
}

class _HistoryContent extends StatelessWidget {
  final HistoryState state;
  const _HistoryContent(this.state);

  static final _dotColors = [AppColors.coral, Colors.black, Colors.black26];

  Widget _section(String title, Color dot, String count) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Icon(Icons.circle, size: 10, color: dot),
          const SizedBox(width: 8),
          Text(title, style: ts(17, w: FontWeight.w800, c: Colors.black)),
          const Spacer(),
          Text(count, style: ts(12, c: Colors.black54)),
        ]),
      );

  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Logo(size: .45),
          Text('History', style: ts(15, c: Colors.black54)),
          Row(children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5)),
                child: const Icon(Icons.search, size: 18)),
            const SizedBox(width: 10),
            const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.teal,
                child: Icon(Icons.person_outline, color: Colors.white, size: 20)),
          ]),
        ]),
        const SizedBox(height: 14),
        HistorySummaryCard(
          recordCount: state.files.length,
          projectCount: state.projectCount,
          totalMb: state.totalMb,
        ),
        const SizedBox(height: 14),
        const Row(children: [
          Expanded(
            child: HistoryFilterPill(
                icon: Icons.calendar_today,
                text: 'Date: Last 30 Days',
                background: AppColors.teal,
                foreground: Colors.white),
          ),
          SizedBox(width: 10),
          Expanded(
            child: HistoryFilterPill(
                icon: Icons.folder_outlined,
                text: 'Folder: All Folders',
                background: AppColors.sand,
                foreground: Color(0xFF55552A)),
          ),
        ]),
        if (state.status == HistoryStatus.empty)
          const EmptyView(
            icon: Icons.history,
            title: 'No scans yet',
            message: 'Documents you scan or upload will show up here.',
          ),
        for (final (i, g) in state.groups.where((g) => g.files.isNotEmpty).indexed) ...[
          _section(g.title, _dotColors[i % _dotColors.length], g.countLabel),
          for (final f in g.files) FileTile(f, showTime: true),
        ],
        const SizedBox(height: 40),
      ]);
}
