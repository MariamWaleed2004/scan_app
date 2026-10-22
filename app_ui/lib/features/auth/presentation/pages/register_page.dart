import 'package:app_ui/core/di/injector.dart';
import 'package:app_ui/core/router/app_routes.dart';
import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/core/widgets/gradient_button.dart';
import 'package:app_ui/core/widgets/logo.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/register_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const _countryCode = '+966';
  final _name = TextEditingController();
  final _title = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    for (final c in [_name, _title, _phone, _password]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (_loading) return;
    setState(() => _loading = true);
    await Injector.registerUser(RegisterParams(
      fullName: _name.text.trim(),
      title: _title.text.trim(),
      countryCode: _countryCode,
      phone: _phone.text.trim(),
      password: _password.text,
    ));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushNamed(context, AppRoutes.otp);
  }

  Widget _label(String en, String a) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(en, style: ts(14, w: FontWeight.w700, c: AppColors.teal)), Text(a, style: ar(13))]),
      );

  Widget _field(String hint, TextEditingController c, {bool obscure = false, IconData? icon}) => TextField(
        controller: c,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint, hintStyle: ts(15, c: Colors.black38),
          prefixIcon: icon == null ? null : Icon(icon, color: Colors.black54),
          filled: true, fillColor: AppColors.fieldBg, contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(24), children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CircleAvatar(
                  backgroundColor: AppColors.fieldBg,
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.teal, size: 20),
                      onPressed: () => Navigator.pop(context))),
              const Logo(size: .4),
              const CircleAvatar(backgroundColor: AppColors.fieldBg, child: Icon(Icons.language, color: AppColors.teal)),
            ]),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.blueTag, borderRadius: BorderRadius.circular(20)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.circle, size: 9, color: AppColors.brick), const SizedBox(width: 6),
                  Text('FEKRA HOUSE · بيت الفكرة', style: ts(12, w: FontWeight.w700, c: AppColors.teal)),
                ]),
              ),
            ),
            const SizedBox(height: 14),
            Text('Create your account', style: ts(32, w: FontWeight.w800, c: Colors.black)),
            Text('Start scanning and organizing your documents effortlessly.', style: ts(13.5, c: Colors.black87)),
            _label('Full Name', 'الاسم الكامل'),
            _field('e.g. Tariq Mansour', _name, icon: Icons.person_outline),
            _label('Title / Role', 'المسمى الوظيفي'),
            _field('e.g. Senior Architect / Project Lead', _title, icon: Icons.work_outline),
            _label('Phone Number', 'رقم الجوال'),
            Row(children: [
              Container(
                height: 58, padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(18)),
                child: Row(children: [
                  Container(width: 26, height: 18, color: const Color(0xFF1F8A45)), const SizedBox(width: 8),
                  Text(_countryCode, style: ts(15)), const Icon(Icons.keyboard_arrow_down, size: 18),
                ]),
              ),
              const SizedBox(width: 10),
              Expanded(child: _field('50 123 4567', _phone)),
            ]),
            _label('Password', 'كلمة المرور'),
            _field('••••••••••••', _password, obscure: true, icon: Icons.lock_outline),
            const SizedBox(height: 12),
            Row(children: [
              for (final c in [AppColors.brick, AppColors.brick, Colors.black12])
                Expanded(child: Container(height: 4, margin: const EdgeInsets.only(right: 8), color: c)),
              Text('Moderate', style: ts(12, c: Colors.black54)),
            ]),
            const SizedBox(height: 14),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 20, height: 20,
                  decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(5)),
                  child: const Icon(Icons.check, size: 14, color: Colors.white)),
              const SizedBox(width: 10),
              Expanded(child: Text('Protected with enterprise OCR encryption & biometric document safeguarding.', style: ts(11.5))),
            ]),
            const SizedBox(height: 20),
            GradientButton('Register →',
                colors: const [Color(0xFF3E6F86), AppColors.teal, AppColors.brick], onTap: _submit),
            const SizedBox(height: 22),
            Center(
                child: Text.rich(TextSpan(text: 'Already have an account? ', style: ts(14), children: [
              TextSpan(text: 'Log in', style: ts(14, w: FontWeight.w700, c: AppColors.brick))
            ]))),
          ]),
        ),
      );
}
