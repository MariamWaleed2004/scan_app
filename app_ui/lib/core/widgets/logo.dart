import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, this.size = 1});

  Widget _bar(double w, double h, Color c) => Container(
      width: w * size,
      height: h * size,
      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(3)));

  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        _bar(12, 72, const Color(0xFFF4A39B)),
        SizedBox(width: 5 * size),
        _bar(12, 50, const Color(0xFFF8C4BE)),
        SizedBox(width: 5 * size),
        _bar(12, 40, Colors.white70),
      ]);
}
