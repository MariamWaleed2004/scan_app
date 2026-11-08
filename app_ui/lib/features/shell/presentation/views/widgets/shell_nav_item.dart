import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

class ShellNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ShellNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: selected ? AppColors.teal : Colors.black54),
          Text(label,
              style: ts(11.5,
                  w: selected ? FontWeight.w700 : FontWeight.w500, c: selected ? AppColors.teal : Colors.black54)),
          Icon(Icons.circle, size: 5, color: selected ? AppColors.coral : Colors.transparent),
        ]),
      );
}
