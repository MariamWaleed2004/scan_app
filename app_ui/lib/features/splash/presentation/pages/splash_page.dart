import 'package:app_ui/core/router/app_routes.dart';
import 'package:app_ui/core/theme/app_text_styles.dart';
import 'package:app_ui/core/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.register),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [Color(0xFF3E6F86), Color(0xFF9A6C78), Color(0xFFEE746B)])),
            child: SafeArea(
              child: Column(children: [
                const Spacer(flex: 3),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Logo(),
                  const SizedBox(width: 14),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('بيت الفكرة',
                        style: GoogleFonts.cairo(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('FEKRA HOUSE', style: ts(11, w: FontWeight.w700, c: Colors.white).copyWith(letterSpacing: 2)),
                  ]),
                ]),
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 36), height: 50, alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(.2), borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white30)),
                  child: Text('Enriching ideas forward...', style: ts(16, c: Colors.white)),
                ),
                const SizedBox(height: 8),
                Text('إثراء الأفكار نحو الغد', style: ar(12, c: Colors.white)),
                const Spacer(flex: 4),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (var i = 0; i < 3; i++)
                    Container(width: 9, height: 9, margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(i == 0 ? 1 : .4)))
                ]),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.lock_outline, size: 14, color: Colors.white70),
                  const SizedBox(width: 6),
                  Text('SECURE INTELLIGENT HUB', style: ts(11, w: FontWeight.w600, c: Colors.white70).copyWith(letterSpacing: 1.5)),
                ]),
                const SizedBox(height: 14),
              ]),
            ),
          ),
        ),
      );
}
