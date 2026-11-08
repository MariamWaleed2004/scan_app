import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/widgets/empty_view.dart';
import 'package:fekra_house/core/widgets/error_view.dart';
import 'package:fekra_house/core/widgets/loading_indicator.dart';
import 'package:fekra_house/features/documents/presentation/views/widgets/file_tile.dart';
import '../../view_model/home_cubit.dart';
import '../../view_model/home_state.dart';
import '../widgets/featured_project_card.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/vault_storage_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => switch (state.status) {
          HomeStatus.loading => const LoadingIndicator(),
          HomeStatus.failure => ErrorView(
              message: state.errorMessage ?? 'Could not load your dashboard.',
              onRetry: context.read<HomeCubit>().load,
            ),
          HomeStatus.success => _HomeContent(state),
        },
      );
}

class _HomeContent extends StatelessWidget {
  final HomeState state;
  const _HomeContent(this.state);

  @override
  Widget build(BuildContext context) => ListView(padding: EdgeInsets.zero, children: [
        if (state.user != null) HomeHeader(user: state.user!),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [
              Expanded(
                child: QuickActionCard(
                    title: 'Upload Files',
                    subtitle: 'PDF, Docs, Images',
                    background: AppColors.sand,
                    foreground: Color(0xFF55552A),
                    icon: Icons.cloud_upload_outlined),
              ),
              SizedBox(width: 12),
              Expanded(
                child: QuickActionCard(
                    title: 'Scan Images',
                    subtitle: 'Auto-edge detect',
                    background: AppColors.pink,
                    foreground: AppColors.brick,
                    icon: Icons.crop_free),
              ),
            ]),
            const SizedBox(height: 14),
            if (state.featuredProject != null) FeaturedProjectCard(state.featuredProject!),
            const SizedBox(height: 18),
            Row(children: [
              Container(width: 4, height: 22, color: AppColors.coral),
              const SizedBox(width: 8),
              Text('Recent Files', style: ts(19, w: FontWeight.w800, c: Colors.black)),
              const Spacer(),
              Text('See all >', style: ts(13, w: FontWeight.w700, c: AppColors.brick)),
            ]),
            const SizedBox(height: 12),
            if (state.recentFiles.isEmpty)
              const EmptyView(
                icon: Icons.description_outlined,
                title: 'No recent files',
                message: 'Scan or upload a document to get started.',
              ),
            for (final f in state.recentFiles) FileTile(f),
            if (state.vaultUsage != null) VaultStorageCard(state.vaultUsage!),
            const SizedBox(height: 40),
          ]),
        ),
      ]);
}
