import 'package:app_ui/core/di/injector.dart';
import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/core/usecase/usecase.dart';
import 'package:app_ui/core/widgets/future_view.dart';
import 'package:app_ui/core/widgets/logo.dart';
import 'package:app_ui/features/documents/domain/entities/history_group.dart';
import 'package:app_ui/features/documents/presentation/widgets/file_tile.dart' show FileTile;
import 'package:flutter/material.dart';


class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static final _dotColors = [AppColors.coral, Colors.black, Colors.black26];

  Widget _section(String t, Color dot, String count) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Icon(Icons.circle, size: 10, color: dot), const SizedBox(width: 8),
          Text(t, style: ts(17, w: FontWeight.w800, c: Colors.black)),
          const Spacer(), Text(count, style: ts(12, c: Colors.black54)),
        ]),
      );

  Widget _pill(IconData ic, String t, Color bgc, Color fg) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(color: bgc, borderRadius: BorderRadius.circular(22)),
          child: Row(children: [
            Icon(ic, size: 16, color: fg), const SizedBox(width: 6),
            Expanded(child: Text(t, overflow: TextOverflow.ellipsis, style: ts(13.5, w: FontWeight.w700, c: fg))),
            Icon(Icons.keyboard_arrow_down, size: 16, color: fg),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureView<List<HistoryGroup>>(
          load: () => Injector.getHistory(const NoParams()),
          builder: (context, groups) {
            final files = groups.expand((g) => g.files).toList();
            final totalMb = files.fold<double>(0, (s, f) => s + f.sizeMb);
            final projects = files.map((f) => f.category).toSet().length;
            return ListView(padding: const EdgeInsets.all(16), children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Logo(size: .45),
                Text('History', style: ts(15, c: Colors.black54)),
                Row(children: [
                  Container(padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5)),
                      child: const Icon(Icons.search, size: 18)),
                  const SizedBox(width: 10),
                  const CircleAvatar(radius: 18, backgroundColor: AppColors.teal, child: Icon(Icons.person_outline, color: Colors.white, size: 20)),
                ]),
              ]),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(24)),
                child: Row(children: [
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${files.length} Archival Records', style: ts(21, w: FontWeight.w800, c: Colors.white)),
                    const SizedBox(height: 4),
                    Text('Synced across $projects projects • ${totalMb.toStringAsFixed(1)} MB total',
                        style: ts(12, c: Colors.white70)),
                  ])),
                  const CircleAvatar(radius: 28, backgroundColor: Colors.white12, child: Icon(Icons.cloud_outlined, color: Colors.white70, size: 28)),
                ]),
              ),
              const SizedBox(height: 14),
              Row(children: [
                _pill(Icons.calendar_today, 'Date: Last 30 Days', AppColors.teal, Colors.white),
                const SizedBox(width: 10),
                _pill(Icons.folder_outlined, 'Folder: All Folders', AppColors.sand, const Color(0xFF55552A)),
              ]),
              for (final (i, g) in groups.indexed) ...[
                _section(g.title, _dotColors[i % _dotColors.length], g.countLabel),
                for (final f in g.files) FileTile(f, showTime: true),
              ],
              const SizedBox(height: 40),
            ]);
          },
        ),
      );
}
