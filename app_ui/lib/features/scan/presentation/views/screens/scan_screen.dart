import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import '../widgets/scan_capture_controls.dart';
import '../widgets/scan_tip_card.dart';

/// UI-only for now. When camera / OCR is integrated, add
/// `features/scan/{domain,data}` (ScanRepository, CaptureDocument use case, ScanCubit, ...).
class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF2F4452),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context)),
                Text('Scan', style: ts(18, w: FontWeight.w800, c: Colors.white)),
                const CircleAvatar(backgroundColor: AppColors.teal, child: Icon(Icons.flash_on, color: Colors.white)),
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFF1F323F), borderRadius: BorderRadius.circular(24)),
              child: Row(children: [
                const Icon(Icons.folder_outlined, color: AppColors.coral, size: 20),
                const SizedBox(width: 8),
                Text('Architecture Projects', style: ts(15, w: FontWeight.w800, c: Colors.white)),
                const Spacer(),
                Text('Change', style: ts(13, w: FontWeight.w800, c: AppColors.coral)),
              ]),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                decoration:
                    BoxDecoration(color: const Color(0xFF7A6A5A), border: Border.all(color: AppColors.coral, width: 1)),
                child: Stack(children: [
                  Center(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                          child: Text('A4 Document Detected', style: ts(13, c: Colors.white)))),
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(14)),
                          child: Text('Page 2 of 3', style: ts(13, w: FontWeight.w800, c: Colors.white)))),
                ]),
              ),
            ),
            const ScanCaptureControls(),
            Container(
              color: AppColors.bg,
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 4, height: 20, color: AppColors.teal),
                  const SizedBox(width: 8),
                  Text('Scan Settings & Tips', style: ts(16, w: FontWeight.w800, c: AppColors.teal)),
                  const Spacer(),
                  Text('Capture بيت الفكرة', style: ar(12, c: AppColors.teal)),
                ]),
                const SizedBox(height: 12),
                const Row(children: [
                  Expanded(
                    child: ScanTipCard(
                        title: 'Smart OCR Ready', subtitle: 'Bilingual Arabic & English...', accent: AppColors.teal),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ScanTipCard(
                        title: 'Target Sync',
                        subtitle: 'Direct upload to Architecture...',
                        accent: Color(0xFF9AAB6B)),
                  ),
                ]),
              ]),
            ),
          ]),
        ),
      );
}
