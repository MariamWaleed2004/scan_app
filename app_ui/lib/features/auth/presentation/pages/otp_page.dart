import 'package:app_ui/core/di/injector.dart';
import 'package:app_ui/core/router/app_routes.dart';
import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/core/usecase/usecase.dart';
import 'package:app_ui/core/widgets/future_view.dart';
import 'package:app_ui/core/widgets/gradient_button.dart';
import 'package:app_ui/core/widgets/logo.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  static const _digits = ['4', '8', '2', '', '', ''];
  static const _keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '☝', '0', '⌫'];

  Future<void> _verify(BuildContext context) async {
    final ok = await Injector.verifyOtp(_digits.join());
    if (ok && context.mounted) Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                CircleAvatar(
                    backgroundColor: AppColors.fieldBg,
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.teal, size: 20),
                        onPressed: () => Navigator.pop(context))),
                const CircleAvatar(backgroundColor: AppColors.fieldBg, child: Text('?', style: TextStyle(color: AppColors.teal))),
              ]),
              const SizedBox(height: 10),
              Stack(alignment: Alignment.center, children: [
                Container(width: 120, height: 130,
                    decoration: const BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(60), top: Radius.circular(12)))),
                const Logo(size: .6),
              ]),
              const SizedBox(height: 14),
              Text('FEKRA HOUSE • بيت الفكرة', style: ts(14, w: FontWeight.w700, c: AppColors.teal)),
              const SizedBox(height: 6),
              Text('Verify your phone number', style: ts(25, w: FontWeight.w800, c: Colors.black)),
              const SizedBox(height: 6),
              SizedBox(
                height: 36,
                child: FutureView<UserEntity>(
                  load: () => Injector.getCurrentUser(const NoParams()),
                  builder: (_, user) => Text.rich(TextSpan(
                      text: "We've sent a 6-digit verification code to ", style: ts(12.5),
                      children: [TextSpan(text: user.phone, style: ts(12.5, w: FontWeight.w800, c: Colors.black))])),
                ),
              ),
              Text('✏️ Edit number', style: ts(14, w: FontWeight.w700, c: AppColors.brick)),
              const SizedBox(height: 18),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                for (var i = 0; i < 6; i++)
                  Container(
                    width: 52, height: 52, alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: i < 3 ? Colors.white : AppColors.fieldBg, borderRadius: BorderRadius.circular(14),
                        border: i == 3 ? Border.all(color: AppColors.teal) : null),
                    child: Text(_digits[i], style: ts(22, w: FontWeight.w800, c: AppColors.teal)),
                  ),
              ]),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(18)),
                child: Row(children: [
                  const CircleAvatar(radius: 18, backgroundColor: AppColors.blueTag),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Resend code in', style: ts(11)), Text('00:30', style: ts(18, w: FontWeight.w800)),
                  ]),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(14)),
                    child: Text('Resend SMS', style: ts(13, w: FontWeight.w700, c: Colors.black38)),
                  ),
                ]),
              ),
              const SizedBox(height: 18),
              GradientButton('Verify →', colors: const [AppColors.coral, AppColors.brick], onTap: () => _verify(context)),
              const SizedBox(height: 18),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3, childAspectRatio: 2.2, mainAxisSpacing: 10, crossAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (final k in _keys)
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: k == '☝' ? Colors.transparent : AppColors.fieldBg, borderRadius: BorderRadius.circular(14)),
                        child: Text(k, style: ts(22, w: FontWeight.w700)),
                      ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
}
