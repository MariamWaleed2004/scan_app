import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/config/routes/app_routes.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import '../../view_model/register_cubit.dart';
import '../../view_model/register_state.dart';
import '../widgets/auth_switch_prompt.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/brand_badge.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void _onStateChanged(BuildContext context, RegisterState state) {
    switch (state.status) {
      case RegisterStatus.success:
        Navigator.pushNamed(context, AppRoutes.otp);
      case RegisterStatus.failure:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Registration failed.')));
      case RegisterStatus.initial:
      case RegisterStatus.submitting:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: _onStateChanged,
            builder: (context, state) => ListView(padding: const EdgeInsets.all(24), children: [
              const AuthTopBar(),
              const SizedBox(height: 16),
              const BrandBadge(),
              const SizedBox(height: 14),
              Text('Create your account', style: ts(32, w: FontWeight.w800, c: Colors.black)),
              Text('Start scanning and organizing your documents effortlessly.', style: ts(13.5, c: Colors.black87)),
              RegisterForm(
                isSubmitting: state.isSubmitting,
                onSubmit: context.read<RegisterCubit>().register,
              ),
              const SizedBox(height: 22),
              AuthSwitchPrompt(
                question: 'Already have an account?',
                action: 'Log in',
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
              ),
            ]),
          ),
        ),
      );
}
