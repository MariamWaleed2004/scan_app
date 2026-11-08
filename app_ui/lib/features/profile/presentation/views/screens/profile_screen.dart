import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/widgets/error_view.dart';
import 'package:fekra_house/core/widgets/loading_indicator.dart';
import 'package:fekra_house/core/widgets/logo.dart';
import '../../view_model/profile_cubit.dart';
import '../../view_model/profile_state.dart';
import '../widgets/credential_tile.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) => switch (state.status) {
            ProfileStatus.loading => const LoadingIndicator(),
            ProfileStatus.failure => ErrorView(
                message: state.errorMessage ?? 'Could not load your profile.',
                onRetry: context.read<ProfileCubit>().load,
              ),
            ProfileStatus.success => _ProfileContent(state),
          },
        ),
      );
}

class _ProfileContent extends StatelessWidget {
  final ProfileState state;
  const _ProfileContent(this.state);

  @override
  Widget build(BuildContext context) {
    final user = state.user!;
    return ListView(padding: const EdgeInsets.all(16), children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Logo(size: .45),
        Text('Profile', style: ts(20, w: FontWeight.w800, c: AppColors.teal)),
        const Icon(Icons.circle_outlined, color: AppColors.teal),
      ]),
      const SizedBox(height: 14),
      ProfileCard(user: user),
      const SizedBox(height: 14),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Verified Credentials', style: ts(14, w: FontWeight.w800, c: AppColors.teal)),
        Text('Read-only Identity', style: ts(11, c: Colors.black54)),
      ]),
      const SizedBox(height: 8),
      CredentialTile(label: 'Full Name', value: user.fullName),
      CredentialTile(label: 'Phone Number', value: user.phone),
      CredentialTile(label: 'Organization / Firm', value: user.organization),
      const SizedBox(height: 14),
      Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: const Color(0xFFEFE9E5), borderRadius: BorderRadius.circular(18)),
        child: Text('Log out', style: ts(17, w: FontWeight.w800, c: AppColors.teal)),
      ),
      const SizedBox(height: 8),
      Center(child: Text('🗑️ Delete account', style: ts(13, c: AppColors.brick))),
      const SizedBox(height: 30),
    ]);
  }
}
