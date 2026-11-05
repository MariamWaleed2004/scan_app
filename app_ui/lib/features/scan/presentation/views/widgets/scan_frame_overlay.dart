import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// Coral corner guides with a scan line and a hint pill across the middle.
class ScanFrameOverlay extends StatelessWidget {
  final String hint;
  const ScanFrameOverlay({super.key, required this.hint});

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
          child: CustomPaint(
            painter: const _CornersPainter(),
            child: Center(
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  color: AppColors.coral.withValues(alpha: .85),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.circle, size: 10, color: AppColors.coral),
                    const SizedBox(width: 8),
                    Text(hint, style: ts(13, w: FontWeight.w600, c: Colors.white)),
                  ]),
                ),
              ]),
            ),
          ),
        ),
      );
}

class _CornersPainter extends CustomPainter {
  const _CornersPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const arm = 30.0;
    final paint = Paint()
      ..color = AppColors.coral
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final r = Offset.zero & size;
    for (final (corner, dx, dy) in [
      (r.topLeft, 1.0, 1.0),
      (r.topRight, -1.0, 1.0),
      (r.bottomLeft, 1.0, -1.0),
      (r.bottomRight, -1.0, -1.0),
    ]) {
      canvas
        ..drawLine(corner, corner.translate(arm * dx, 0), paint)
        ..drawLine(corner, corner.translate(0, arm * dy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
