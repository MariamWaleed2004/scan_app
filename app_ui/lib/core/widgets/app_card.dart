import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets pad;
  const AppCard({super.key, required this.child, this.pad = const EdgeInsets.all(14)});

  @override
  Widget build(BuildContext context) => Container(
        padding: pad,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 10, offset: const Offset(0, 3))
            ]),
        child: child,
      );
}
