import 'package:app_ui/core/di/injector.dart';
import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/core/usecase/usecase.dart';
import 'package:app_ui/core/widgets/app_card.dart';
import 'package:app_ui/core/widgets/future_view.dart';
import 'package:app_ui/features/auth/domain/entities/user_entity.dart';
import 'package:app_ui/features/documents/domain/entities/document_file.dart';
import 'package:app_ui/features/documents/domain/entities/project_summary.dart';
import 'package:app_ui/features/documents/domain/entities/storage_usage.dart';
import 'package:app_ui/features/documents/presentation/widgets/file_tile.dart';
import 'package:flutter/material.dart';


typedef _HomeData = ({
  UserEntity user,
  ProjectSummary project,
  List<DocumentFile> recent,
  StorageUsage vault,
});

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _none = NoParams();

  Future<_HomeData> _load() async {
  final UserEntity user =
      await Injector.getCurrentUser(_none);

  final ProjectSummary project =
      await Injector.getFeaturedProject(_none);

  final List<DocumentFile> recent =
      await Injector.getRecentFiles(_none);

  final StorageUsage vault =
      await Injector.getVaultUsage(_none);

  return (
    user: user,
    project: project,
    recent: recent,
    vault: vault,
  );
}

  Widget _action(String t, String s, Color bgc, Color fg, IconData ic) => Expanded(
        child: Container(
          height: 118, padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: bgc, borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Icon(ic, color: fg, size: 28)),
            const Spacer(),
            Text(t, style: ts(16, w: FontWeight.w800, c: fg)),
            Text(s, style: ts(11, c: fg)),
          ]),
        ),
      );

  Widget _header(UserEntity user) => Container(
        padding: const EdgeInsets.fromLTRB(20, 54, 20, 24),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Color(0xFF3E6F86), Color(0xFFEE746B)])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white30)),
              child: Text('EN | العربية', style: ts(13, c: Colors.white)),
            ),
            const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.notifications_none, color: Colors.white)),
          ]),
          const SizedBox(height: 16),
          Text('Hello, ${user.firstName} 👋', style: ts(28, w: FontWeight.w800, c: Colors.white)),
          Row(children: [
            const Icon(Icons.circle, size: 8, color: Color(0xFFE8E08A)), const SizedBox(width: 6),
            Text(user.title, style: ts(13, c: Colors.white)),
          ]),
          const SizedBox(height: 16),
          Container(
            height: 52, padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(26)),
            child: Row(children: [
              const Icon(Icons.search, color: Colors.black45), const SizedBox(width: 8),
              Text('Search PDFs, folders, tags...', style: ts(14, c: Colors.black45)),
            ]),
          ),
        ]),
      );

  Widget _project(ProjectSummary p) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: const Color(0xFFF1E6E3), borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Container(width: 38, height: 38,
              decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8))),
          const SizedBox(width: 14),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p.name, style: ts(14.5, w: FontWeight.w800, c: Colors.black)),
            Text('${p.blueprintCount} blueprints • Synced ${p.syncedLabel}', style: ts(11.5, c: Colors.black54)),
          ])),
          for (final (i, m) in p.memberInitials.indexed) ...[
            CircleAvatar(
                radius: 15,
                backgroundColor: i.isEven ? AppColors.blueTag : AppColors.pink,
                child: Text(m, style: const TextStyle(fontSize: 12))),
            const SizedBox(width: 4),
          ],
        ]),
      );

  Widget _vault(StorageUsage u) => AppCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Vault Storage', style: ts(14, w: FontWeight.w800, c: AppColors.teal)),
            Text(u.label, style: ts(12, c: Colors.black54)),
          ]),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Row(children: [
              Expanded(flex: 5, child: Container(height: 8, color: AppColors.teal)),
              Expanded(flex: 3, child: Container(height: 8, color: AppColors.coral)),
              Expanded(flex: 2, child: Container(height: 8, color: AppColors.olive)),
              Expanded(flex: 1, child: Container(height: 8, color: Colors.black12)),
            ]),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) => FutureView<_HomeData>(
        load: _load,
        builder: (context, d) => ListView(padding: EdgeInsets.zero, children: [
          _header(d.user),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                _action('Upload Files', 'PDF, Docs, Images', AppColors.sand, const Color(0xFF55552A), Icons.cloud_upload_outlined),
                const SizedBox(width: 12),
                _action('Scan Images', 'Auto-edge detect', AppColors.pink, AppColors.brick, Icons.crop_free),
              ]),
              const SizedBox(height: 14),
              _project(d.project),
              const SizedBox(height: 18),
              Row(children: [
                Container(width: 4, height: 22, color: AppColors.coral), const SizedBox(width: 8),
                Text('Recent Files', style: ts(19, w: FontWeight.w800, c: Colors.black)),
                const Spacer(),
                Text('See all >', style: ts(13, w: FontWeight.w700, c: AppColors.brick)),
              ]),
              const SizedBox(height: 12),
              for (final f in d.recent) FileTile(f),
              _vault(d.vault),
              const SizedBox(height: 40),
            ]),
          ),
        ]),
      );
}
