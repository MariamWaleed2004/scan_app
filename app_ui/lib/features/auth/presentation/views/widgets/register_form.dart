import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/utils/validators.dart';
import 'package:fekra_house/core/widgets/gradient_button.dart';
import 'auth_field_label.dart';
import 'auth_text_field.dart';
import 'phone_input_field.dart';

typedef RegisterSubmit = void Function({
  required String fullName,
  required String title,
  required String countryCode,
  required String phone,
  required String password,
});

/// Owns the form key and text controllers (presentation concern), validates
/// the input format, and hands plain values to [onSubmit]. It knows nothing
/// about the Cubit or use cases.
class RegisterForm extends StatefulWidget {
  final RegisterSubmit onSubmit;
  final bool isSubmitting;
  const RegisterForm({super.key, required this.onSubmit, this.isSubmitting = false});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  var _submitted = false;
  final _name = TextEditingController();
  final _title = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    for (final c in [_name, _title, _phone, _password]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (widget.isSubmitting) return;
    setState(() => _submitted = true);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit(
      fullName: _name.text,
      title: _title.text,
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
          const AuthFieldLabel('Full Name', 'الاسم الكامل'),
          AuthTextField(
            hint: 'e.g. Tariq Mansour',
            controller: _name,
            icon: Icons.person_outline,
            validator: (v) => Validators.notEmpty(v, field: 'Full name'),
          ),
          const AuthFieldLabel('Title / Role', 'المسمى الوظيفي'),
          AuthTextField(
            hint: 'e.g. Senior Architect / Project Lead',
            controller: _title,
            icon: Icons.work_outline,
            validator: (v) => Validators.notEmpty(v, field: 'Title'),
          ),
          const AuthFieldLabel('Phone Number', 'رقم الجوال'),
          PhoneInputField(controller: _phone),
          const AuthFieldLabel('Password', 'كلمة المرور'),
          AuthTextField(
            hint: '••••••••••••',
            controller: _password,
            obscure: true,
            icon: Icons.lock_outline,
            validator: Validators.password,
          ),
          const SizedBox(height: 12),
          Row(children: [
            for (final c in [AppColors.brick, AppColors.brick, Colors.black12])
              Expanded(child: Container(height: 4, margin: const EdgeInsets.only(right: 8), color: c)),
            Text('Moderate', style: ts(12, c: Colors.black54)),
          ]),
          const SizedBox(height: 14),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.check, size: 14, color: Colors.white)),
            const SizedBox(width: 10),
            Expanded(
                child: Text('Protected with enterprise OCR encryption & biometric document safeguarding.',
                    style: ts(11.5))),
          ]),
          const SizedBox(height: 20),
          GradientButton('Register →',
              colors: const [Color(0xFF3E6F86), AppColors.teal, AppColors.brick], onTap: _submit),
        ]),
      );
}
