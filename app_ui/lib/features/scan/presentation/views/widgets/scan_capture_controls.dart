import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// Page thumbnails + shutter + "Save PDF" action.
class ScanCaptureControls extends StatelessWidget {
  const ScanCaptureControls({super.key});

  Widget _thumb(Color c, {Widget? child}) => Container(
      width: 74,
      height: 66,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(10)),
      child: child);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 8),
        child: Column(children: [
          Row(children: [
            _thumb(Colors.white),
            const SizedBox(width: 10),
            _thumb(const Color(0xFFE6EDF4)),
            const SizedBox(width: 10),
            _thumb(const Color(0xFF506573), child: const Icon(Icons.add, color: Colors.white)),
          ]),
          const SizedBox(height: 12),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(children: [
              const CircleAvatar(radius: 18, backgroundColor: Color(0xFF506573)),
              Text('Auto', style: ts(11, c: Colors.white70)),
            ]),
            const Spacer(),
            Container(
              width: 78,
              height: 78,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
              child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.coral),
                  child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30)),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(28)),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('FINISH', style: ts(9, w: FontWeight.w800, c: Colors.white)),
                  Text('Save PDF', style: ts(17, w: FontWeight.w800, c: Colors.white)),
                ]),
                const SizedBox(width: 8),
                const Icon(Icons.picture_as_pdf, color: Colors.white),
              ]),
            ),
          ]),
        ]),
      );
}
