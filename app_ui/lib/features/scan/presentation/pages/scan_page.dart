import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';


/// UI-only for now. When camera / OCR is integrated, add
/// `features/scan/{domain,data}` (ScanRepository, CaptureDocument use case, ...).
class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  Widget _thumb(Color c, {Widget? child}) => Container(
      width: 74, height: 66, alignment: Alignment.center,
      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(10)), child: child);

  Widget _tip(String t, String s, Color bgc) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(14), height: 130,
          decoration: BoxDecoration(color: const Color(0xFFF1EBE7), borderRadius: BorderRadius.circular(18)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: bgc, borderRadius: BorderRadius.circular(12))),
            const Spacer(),
            Text(t, style: ts(14, w: FontWeight.w800, c: Colors.black)),
            Text(s, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(11, c: Colors.black54)),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF2F4452),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(icon: const Icon(Icons.close, color: Colors.white, size: 30), onPressed: () => Navigator.pop(context)),
                Text('Scan', style: ts(18, w: FontWeight.w800, c: Colors.white)),
                const CircleAvatar(backgroundColor: AppColors.teal, child: Icon(Icons.flash_on, color: Colors.white)),
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFF1F323F), borderRadius: BorderRadius.circular(24)),
              child: Row(children: [
                const Icon(Icons.folder_outlined, color: AppColors.coral, size: 20), const SizedBox(width: 8),
                Text('Architecture Projects', style: ts(15, w: FontWeight.w800, c: Colors.white)),
                const Spacer(),
                Text('Change', style: ts(13, w: FontWeight.w800, c: AppColors.coral)),
              ]),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(color: const Color(0xFF7A6A5A), border: Border.all(color: AppColors.coral, width: 1)),
                child: Stack(children: [
                  Center(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                          child: Text('A4 Document Detected', style: ts(13, c: Colors.white)))),
                  Positioned(
                      right: 10, bottom: 10,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(14)),
                          child: Text('Page 2 of 3', style: ts(13, w: FontWeight.w800, c: Colors.white)))),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 14, 22, 8),
              child: Column(children: [
                Row(children: [
                  _thumb(Colors.white), const SizedBox(width: 10),
                  _thumb(const Color(0xFFE6EDF4)), const SizedBox(width: 10),
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
                    width: 78, height: 78, padding: const EdgeInsets.all(5),
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
            ),
            Container(
              color: AppColors.bg, padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 4, height: 20, color: AppColors.teal), const SizedBox(width: 8),
                  Text('Scan Settings & Tips', style: ts(16, w: FontWeight.w800, c: AppColors.teal)),
                  const Spacer(), Text('Capture بيت الفكرة', style: ar(12, c: AppColors.teal)),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  _tip('Smart OCR Ready', 'Bilingual Arabic & English...', AppColors.teal),
                  const SizedBox(width: 12),
                  _tip('Target Sync', 'Direct upload to Architecture...', const Color(0xFF9AAB6B)),
                ]),
              ]),
            ),
          ]),
        ),
      );
}
