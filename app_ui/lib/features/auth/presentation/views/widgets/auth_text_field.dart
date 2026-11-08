import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscure;
  final IconData? icon;
  final TextInputType? keyboardType;

  const AuthTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
    this.obscure = false,
    this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: ts(15, c: Colors.black38),
          prefixIcon: icon == null ? null : Icon(icon, color: Colors.black54),
          filled: true,
          fillColor: AppColors.fieldBg,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        ),
      );
}
