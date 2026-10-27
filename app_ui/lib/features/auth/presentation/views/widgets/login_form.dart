import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/utils/validators.dart';
import 'package:fekra_house/core/widgets/gradient_button.dart';
import 'auth_field_label.dart';
import 'auth_text_field.dart';
import 'phone_input_field.dart';

typedef LoginSubmit = void Function({
  required String countryCode,
  required String phone,
  required String password,
});

/// Owns the form key and controllers, validates the format, and hands plain
/// values to [onSubmit]. Knows nothing about the Cubit or use cases.
class LoginForm extends StatefulWidget {
  final LoginSubmit onSubmit;
  final bool isSubmitting;
  const LoginForm({super.key, required this.onSubmit, this.isSubmitting = false});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var _submitted = false;
  final _phone = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.isSubmitting) return;
    setState(() => _submitted = true);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit(
      countryCode: PhoneInputField.defaultCountryCode,
      phone: _phone.text,
      password: _password.text,
    );
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const AuthFieldLabel('Phone Number', 'رقم الجوال'),
          PhoneInputField(controller: _phone),
          const AuthFieldLabel('Password', 'كلمة المرور'),
          AuthTextField(
            hint: '••••••••••••',
            controller: _password,
            obscure: true,
            icon: Icons.lock_outline,
            validator: (v) => Validators.notEmpty(v, field: 'Password'),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text('Forgot password?', style: ts(13, w: FontWeight.w700, c: AppColors.brick)),
          ),
          const SizedBox(height: 24),
          widget.isSubmitting
              ? const SizedBox(
                  height: 56,
                  child: Center(child: CircularProgressIndicator(color: AppColors.coral)),
                )
              : GradientButton('Log in →',
                  colors: const [Color(0xFF3E6F86), AppColors.teal, AppColors.brick], onTap: _submit),
        ]),
      );
}
