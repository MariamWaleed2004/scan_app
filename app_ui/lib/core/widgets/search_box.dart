import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hint;
  final Color fill;
  const SearchBox(this.hint, {super.key, this.fill = AppColors.fieldBg});

  @override
  Widget build(BuildContext context) => Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          const Icon(Icons.search, color: Colors.black45),
          const SizedBox(width: 8),
          Text(hint, style: ts(14, c: Colors.black45)),
        ]),
      );
}

