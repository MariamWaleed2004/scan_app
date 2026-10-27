import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/utils/validators.dart';
import 'auth_text_field.dart';

/// Country-code chip + local phone number field.
class PhoneInputField extends StatelessWidget {
  static const defaultCountryCode = '+966';

  final TextEditingController controller;
  final String countryCode;

  const PhoneInputField({super.key, required this.controller, this.countryCode = defaultCountryCode});

  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(18)),
          child: Row(children: [
            Container(width: 26, height: 18, color: const Color(0xFF1F8A45)),
            const SizedBox(width: 8),
            Text(countryCode, style: ts(15)),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ]),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AuthTextField(
            hint: '50 123 4567',
            controller: controller,
            validator: Validators.phone,
            keyboardType: TextInputType.phone,
          ),
        ),
      ]);
}
