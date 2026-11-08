import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// Generic failure state with an optional retry action.
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const ErrorView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.error_outline, color: AppColors.brick, size: 40),
            const SizedBox(height: 10),
            Text(message, textAlign: TextAlign.center, style: ts(14, c: Colors.black54)),
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              TextButton(
                onPressed: onRetry,
                child: Text('Try again', style: ts(14, w: FontWeight.w700, c: AppColors.teal)),
              ),
            ],
          ]),
        ),
      );
}
