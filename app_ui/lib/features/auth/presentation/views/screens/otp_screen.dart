import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/config/routes/app_routes.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/widgets/gradient_button.dart';
import 'package:fekra_house/core/widgets/loading_indicator.dart';
import 'package:fekra_house/core/widgets/logo.dart';
import '../../view_model/otp_cubit.dart';
import '../../view_model/otp_state.dart';
import '../widgets/otp_code_boxes.dart';
import '../widgets/otp_keypad.dart';
import '../widgets/resend_code_card.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  /// Mock entered digits (no keypad input wired yet).
  static const _digits = ['4', '8', '2', '', '', ''];

  void _onStateChanged(BuildContext context, OtpState state) {
    if (state.status == OtpStatus.verified) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else if (state.status == OtpStatus.failure && state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocListener<OtpCubit, OtpState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: _onStateChanged,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  CircleAvatar(
                      backgroundColor: AppColors.fieldBg,
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppColors.teal, size: 20),
                          onPressed: () => Navigator.pop(context))),
                  const CircleAvatar(
                      backgroundColor: AppColors.fieldBg, child: Text('?', style: TextStyle(color: AppColors.teal))),
                ]),
                const SizedBox(height: 10),
                Stack(alignment: Alignment.center, children: [
                  Container(
                      width: 120,
                      height: 130,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(bottom: Radius.circular(60), top: Radius.circular(12)))),
                  const Logo(size: .6),
                ]),
                const SizedBox(height: 14),
                Text('FEKRA HOUSE • بيت الفكرة', style: ts(14, w: FontWeight.w700, c: AppColors.teal)),
                const SizedBox(height: 6),
                Text('Verify your phone number', style: ts(25, w: FontWeight.w800, c: Colors.black)),
                const SizedBox(height: 6),
                SizedBox(
                  height: 36,
                  child: BlocBuilder<OtpCubit, OtpState>(
                    buildWhen: (prev, curr) => prev.phone != curr.phone,
                    builder: (_, state) => state.phone == null
                        ? const LoadingIndicator()
                        : Text.rich(TextSpan(
                            text: "We've sent a 6-digit verification code to ",
                            style: ts(12.5),
                            children: [
                                TextSpan(text: state.phone, style: ts(12.5, w: FontWeight.w800, c: Colors.black))
                              ])),
                  ),
                ),
                Text('✏️ Edit number', style: ts(14, w: FontWeight.w700, c: AppColors.brick)),
                const SizedBox(height: 18),
                const OtpCodeBoxes(digits: _digits),
                const SizedBox(height: 18),
                const ResendCodeCard(),
                const SizedBox(height: 18),
                GradientButton('Verify →',
                    colors: const [AppColors.coral, AppColors.brick],
                    onTap: () => context.read<OtpCubit>().verify(_digits.join())),
                const SizedBox(height: 18),
                const Expanded(child: OtpKeypad()),
              ]),
            ),
          ),
        ),
      );
}
