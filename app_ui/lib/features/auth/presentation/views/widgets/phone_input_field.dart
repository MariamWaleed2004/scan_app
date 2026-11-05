import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/core/utils/validators.dart';
import '../../../domain/entities/country.dart';
import 'auth_text_field.dart';

/// Country picker (flag + dial code dropdown) + national phone number field.
/// The selected [country] is owned by the parent form.
class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final Country country;
  final ValueChanged<Country> onCountryChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    required this.country,
    required this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        PopupMenuButton<Country>(
          initialValue: country,
          onSelected: onCountryChanged,
          tooltip: 'Select country',
          position: PopupMenuPosition.under,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          itemBuilder: (_) => [
            for (final c in Country.all)
              PopupMenuItem<Country>(
                value: c,
                child: Row(children: [
                  Text(c.flag, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(c.name, overflow: TextOverflow.ellipsis, style: ts(14))),
                  const SizedBox(width: 8),
                  Text(c.dialCode, style: ts(13, c: Colors.black54)),
                ]),
              ),
          ],
          child: Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(18)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(country.flag, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(country.dialCode, style: ts(15)),
              const Icon(Icons.keyboard_arrow_down, size: 18),
            ]),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AuthTextField(
            hint: country.example,
            controller: controller,
            keyboardType: TextInputType.phone,
            validator: (v) => Validators.phone(v, minDigits: country.minDigits, maxDigits: country.maxDigits),
          ),
        ),
      ]);
}
