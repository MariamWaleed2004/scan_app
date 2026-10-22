import 'package:app_ui/core/router/app_routes.dart';
import 'package:app_ui/core/theme/app_colors.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/features/folders/presentation/pages/folders_page.dart';
import 'package:app_ui/features/history/presentation/pages/history_page.dart';
import 'package:app_ui/features/home/presentation/pages/home_page.dart';
import 'package:app_ui/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';


class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _pages = const [HomePage(), FoldersPage(), HistoryPage(), ProfilePage()];

  Widget _item(int idx, IconData icon, String label) {
    final on = _index == idx;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _index = idx),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: on ? AppColors.teal : Colors.black54),
          Text(label, style: ts(11.5, w: on ? FontWeight.w700 : FontWeight.w500, c: on ? AppColors.teal : Colors.black54)),
          Icon(Icons.circle, size: 5, color: on ? AppColors.coral : Colors.transparent),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: _index, children: _pages),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            width: 68, height: 68,
            child: FloatingActionButton(
              backgroundColor: AppColors.coral, shape: const CircleBorder(), elevation: 4,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.scan),
              child: const Icon(Icons.document_scanner_outlined, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(height: 22),
        ]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white, shape: const CircularNotchedRectangle(), notchMargin: 8, height: 70,
          padding: EdgeInsets.zero,
          child: Row(children: [
            _item(0, Icons.home_outlined, 'Home'),
            _item(1, Icons.folder_open, 'Folders'),
            const Expanded(child: SizedBox()),
            _item(2, Icons.history, 'History'),
            _item(3, Icons.account_circle_outlined, 'Profile'),
          ]),
        ),
      );
}
