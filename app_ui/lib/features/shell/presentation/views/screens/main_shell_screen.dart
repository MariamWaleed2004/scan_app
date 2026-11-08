import 'package:flutter/material.dart';
import 'package:fekra_house/config/routes/app_routes.dart';
import 'package:fekra_house/config/theme/app_colors.dart';
import '../widgets/shell_nav_item.dart';

/// Bottom-nav shell: owns tab switching and navigation only.
/// The tab screens (with their BlocProviders) are composed by the router and
/// passed in, so the shell doesn't depend on other features.
class MainShellScreen extends StatefulWidget {
  /// In order: Home, Folders, History, Profile.
  final List<Widget> tabs;
  const MainShellScreen({super.key, required this.tabs});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _index = 0;

  Widget _item(int idx, IconData icon, String label) => Expanded(
        child: ShellNavItem(
          icon: icon,
          label: label,
          selected: _index == idx,
          onTap: () => setState(() => _index = idx),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: _index, children: widget.tabs),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            width: 68,
            height: 68,
            child: FloatingActionButton(
              backgroundColor: AppColors.coral,
              shape: const CircleBorder(),
              elevation: 4,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.scan),
              child: const Icon(Icons.document_scanner_outlined, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(height: 22),
        ]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          height: 70,
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
