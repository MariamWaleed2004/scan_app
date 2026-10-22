import 'package:app_ui/core/di/injector.dart';
import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/core/usecase/usecase.dart';
import 'package:app_ui/core/widgets/app_card.dart';
import 'package:app_ui/core/widgets/future_view.dart';
import 'package:app_ui/core/widgets/gradient_button.dart';
import 'package:app_ui/core/widgets/logo.dart';
import 'package:app_ui/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget _cred(String l, String v) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: AppCard(
          pad: const EdgeInsets.all(12),
          child: Row(children: [
            Container(width: 44, height: 44,
                decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(12))),
            const SizedBox(width: 12),
            Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l, style: ts(11.5, c: Colors.black54)),
              Text(v, style: ts(16, w: FontWeight.w800, c: Colors.black)),
            ])),
            const CircleAvatar(radius: 17, backgroundColor: AppColors.fieldBg, child: Icon(Icons.copy, size: 16, color: Colors.black54)),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureView<UserEntity>(
          load: () => Injector.getCurrentUser(const NoParams()),
          builder: (context, user) => ListView(padding: const EdgeInsets.all(16), children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Logo(size: .45),
              Text('Profile', style: ts(20, w: FontWeight.w800, c: AppColors.teal)),
              const Icon(Icons.circle_outlined, color: AppColors.teal),
            ]),
            const SizedBox(height: 14),
            AppCard(
              pad: const EdgeInsets.all(14),
              child: Column(children: [
                Stack(clipBehavior: Clip.none, children: [
                  Container(
                    width: 78, height: 78, alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.coral, width: 4)),
                    child: Text(user.initials, style: ts(26, w: FontWeight.w800, c: AppColors.teal)),
                  ),
                  Positioned(right: -4, bottom: -4,
                      child: Container(width: 24, height: 24,
                          decoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle))),
                ]),
                const SizedBox(height: 10),
                Text(user.fullName, style: ts(21, w: FontWeight.w800, c: Colors.black)),
                Text('Bilingual Workspace Member', style: ts(12, c: Colors.black54)),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity, padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(16)),
                  child: Column(children: [
                    Text(user.title, style: ts(16, c: AppColors.teal)),
                    Text('Tap to edit title', style: ts(10.5, c: Colors.black45)),
                  ]),
                ),
                const SizedBox(height: 10),
                const GradientButton('Save changes', colors: [AppColors.coral, AppColors.coral]),
              ]),
            ),
            const SizedBox(height: 14),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Verified Credentials', style: ts(14, w: FontWeight.w800, c: AppColors.teal)),
              Text('Read-only Identity', style: ts(11, c: Colors.black54)),
            ]),
            const SizedBox(height: 8),
            _cred('Full Name', user.fullName),
            _cred('Phone Number', user.phone),
            _cred('Organization / Firm', user.organization),
            const SizedBox(height: 14),
            Container(
              height: 56, alignment: Alignment.center,
              decoration: BoxDecoration(color: const Color(0xFFEFE9E5), borderRadius: BorderRadius.circular(18)),
              child: Text('Log out', style: ts(17, w: FontWeight.w800, c: AppColors.teal)),
            ),
            const SizedBox(height: 8),
            Center(child: Text('🗑️ Delete account', style: ts(13, c: AppColors.brick))),
            const SizedBox(height: 30),
          ]),
        ),
      );
}
