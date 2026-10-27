import 'package:flutter/material.dart';
import 'package:fekra_house/config/theme/app_text_styles.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';

class HomeHeader extends StatelessWidget {
  final User user;
  const HomeHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(20, 54, 20, 24),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3E6F86), Color(0xFFEE746B)])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white30)),
              child: Text('EN | العربية', style: ts(13, c: Colors.white)),
            ),
            const CircleAvatar(
                backgroundColor: Colors.white24, child: Icon(Icons.notifications_none, color: Colors.white)),
          ]),
          const SizedBox(height: 16),
          Text('Hello, ${user.firstName} 👋', style: ts(28, w: FontWeight.w800, c: Colors.white)),
          Row(children: [
            const Icon(Icons.circle, size: 8, color: Color(0xFFE8E08A)),
            const SizedBox(width: 6),
            Text(user.title, style: ts(13, c: Colors.white)),
          ]),
          const SizedBox(height: 16),
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(26)),
            child: Row(children: [
              const Icon(Icons.search, color: Colors.black45),
              const SizedBox(width: 8),
              Text('Search PDFs, folders, tags...', style: ts(14, c: Colors.black45)),
            ]),
          ),
        ]),
      );
}
