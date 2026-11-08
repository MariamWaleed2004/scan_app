import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';

/// Bottom overlay: captured-page thumbnails (tap × to remove) + "next page" tile,
/// a page badge, then the shutter and "Save PDF". A null callback disables a control.
class ScanCaptureControls extends StatelessWidget {
  final List<String> pages;
  final ValueChanged<int> onRemovePage;
  final VoidCallback? onCapture;
  final VoidCallback? onSave;
  final bool saving;

  const ScanCaptureControls({
    super.key,
    required this.pages,
    required this.onRemovePage,
    required this.onCapture,
    required this.onSave,
    this.saving = false,
  });

  static const _thumbW = 54.0, _thumbH = 66.0;

  Widget _thumb(int index) => Padding(
        padding: const EdgeInsets.only(right: 10, top: 6),
        child: Stack(clipBehavior: Clip.none, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(File(pages[index]), width: _thumbW, height: _thumbH, fit: BoxFit.cover, cacheWidth: 160),
          ),
          Positioned(
            left: 4,
            bottom: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
              child: Text('${index + 1}', style: ts(10, w: FontWeight.w800, c: Colors.white)),
            ),
          ),
          Positioned(
            right: -6,
            top: -6,
            child: GestureDetector(
              onTap: () => onRemovePage(index),
              child: const CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.coral,
                child: Icon(Icons.close, size: 12, color: Colors.white),
              ),
            ),
          ),
        ]),
      );

  Widget _nextPageTile() => Padding(
        padding: const EdgeInsets.only(top: 6),
        child: GestureDetector(
          onTap: onCapture,
          child: Container(
            width: _thumbW,
            height: _thumbH,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white38),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.add, color: Colors.white),
              Text('Page ${pages.length + 1}', style: ts(10, c: Colors.white70)),
            ]),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black54, Colors.black87],
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(
              child: SizedBox(
                height: _thumbH + 6,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  for (var i = 0; i < pages.length; i++) _thumb(i),
                  _nextPageTile(),
                ]),
              ),
            ),
            if (pages.isNotEmpty) ...[
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(14)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.filter_none, color: AppColors.coral, size: 18),
                  const SizedBox(width: 8),
                  Text('${pages.length} ${pages.length == 1 ? 'page' : 'pages'}',
                      style: ts(14, w: FontWeight.w800, c: Colors.white)),
                ]),
              ),
            ],
          ]),
          const SizedBox(height: 18),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // Left: page counter (balances the Save button).
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('${pages.length}', style: ts(16, w: FontWeight.w800, c: Colors.white)),
                    Text('Pages', style: ts(9.5, c: Colors.white70)),
                  ]),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onCapture,
              child: Opacity(
                opacity: onCapture == null ? .4 : 1,
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.coral),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 32),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: GestureDetector(
                  onTap: onSave,
                  child: Opacity(
                    opacity: onSave == null && !saving ? .45 : 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(18)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('FINISH', style: ts(9, w: FontWeight.w800, c: Colors.white)),
                          Text(saving ? 'Saving…' : 'Save PDF', style: ts(15, w: FontWeight.w800, c: Colors.white)),
                        ]),
                        const SizedBox(width: 6),
                        saving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                              )
                            : const Icon(Icons.picture_as_pdf, color: Colors.white, size: 22),
                      ]),
                    ),
                  ),
                ),
                ),
              ),
            ),
          ]),
        ]),
      );
}
