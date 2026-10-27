import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/config/routes/app_routes.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import '../../view_model/login_cubit.dart';
import '../../view_model/login_state.dart';
import '../widgets/auth_switch_prompt.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/brand_badge.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onStateChanged(BuildContext context, LoginState state) {
    switch (state.status) {
      case LoginStatus.success:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
      case LoginStatus.failure:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Login failed.')));
      case LoginStatus.initial:
      case LoginStatus.submitting:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: _onStateChanged,
            builder: (context, state) => ListView(padding: const EdgeInsets.all(24), children: [
              const AuthTopBar(),
              const SizedBox(height: 16),
              const BrandBadge(),
              const SizedBox(height: 14),
              Text('Welcome back', style: ts(32, w: FontWeight.w800, c: Colors.black)),
              Text('Log in to access your scanned documents and folders.', style: ts(13.5, c: Colors.black87)),
              const SizedBox(height: 8),
              LoginForm(
                isSubmitting: state.isSubmitting,
                onSubmit: context.read<LoginCubit>().login,
              ),
              const SizedBox(height: 22),
              AuthSwitchPrompt(
                question: "Don't have an account?",
                action: 'Register',
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.register),
              ),
            ]),
          ),
        ),
      );
}
