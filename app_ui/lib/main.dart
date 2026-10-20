import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const teal = Color(0xFF1F4E63);
const coral = Color(0xFFFF7367);
const brick = Color(0xFFA32F2F);
const olive = Color(0xFF8A8A3C);
const bg = Color(0xFFFFF6F3);
const fieldBg = Color(0xFFF8F0EC);
const sand = Color(0xFFE8E6CE);
const pink = Color(0xFFFFD9D6);
const blueTag = Color(0xFFCFE8F7);

void main() => runApp(const FekraApp());

class FekraApp extends StatelessWidget {
  const FekraApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: bg,
          textTheme: GoogleFonts.outfitTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: coral),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
          '/register': (_) => const RegisterScreen(),
          '/otp': (_) => const OtpScreen(),
          '/home': (_) => const MainShell(),
          '/scan': (_) => const ScanScreen(),
        },
      );
}

// ───────── Shared widgets ─────────
TextStyle ts(double s, {FontWeight w = FontWeight.w500, Color c = Colors.black87}) =>
    GoogleFonts.outfit(fontSize: s, fontWeight: w, color: c);
TextStyle ar(double s, {Color c = Colors.black54}) =>
    GoogleFonts.cairo(fontSize: s, color: c);

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, this.size = 1});
  Widget bar(double w, double h, Color c) => Container(
      width: w * size, height: h * size,
      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(3)));
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        bar(12, 72, const Color(0xFFF4A39B)), SizedBox(width: 5 * size),
        bar(12, 50, const Color(0xFFF8C4BE)), SizedBox(width: 5 * size),
        bar(12, 40, Colors.white70),
      ]);
}

class GradBtn extends StatelessWidget {
  final String text; final List<Color> colors; final VoidCallback? onTap;
  const GradBtn(this.text, {super.key, required this.colors, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56, alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(18)),
          child: Text(text, style: ts(18, w: FontWeight.w700, c: Colors.white)),
        ),
      );
}

class Card2 extends StatelessWidget {
  final Widget child; final EdgeInsets pad;
  const Card2({super.key, required this.child, this.pad = const EdgeInsets.all(14)});
  @override
  Widget build(BuildContext context) => Container(
        padding: pad,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10, offset: const Offset(0, 3))]),
        child: child,
      );
}

class Tag extends StatelessWidget {
  final String text; final Color color;
  const Tag(this.text, this.color, {super.key});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.folder_outlined, size: 13, color: Colors.black54),
          const SizedBox(width: 4),
          Text(text, style: ts(11, w: FontWeight.w600, c: Colors.black87)),
        ]),
      );
}

class FileTile extends StatelessWidget {
  final String name, meta, tag; final Color tagColor; final String? time;
  const FileTile(this.name, this.tag, this.tagColor, this.meta, {super.key, this.time});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card2(
          child: Row(children: [
            Container(
                width: 48, height: 60, alignment: Alignment.center,
                decoration: BoxDecoration(color: const Color(0xFFFBE5E1), borderRadius: BorderRadius.circular(10)),
                child: Text('PDF', style: ts(11, w: FontWeight.w700, c: brick))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(14.5, w: FontWeight.w700)),
                const SizedBox(height: 4),
                Tag(tag, tagColor),
                const SizedBox(height: 4),
                Text(meta, style: ts(12, c: Colors.black54)),
              ]),
            ),
            Column(children: [
              const Icon(Icons.more_vert, size: 20, color: Colors.black45),
              if (time != null) Text(time!, style: ts(12, c: Colors.black54)),
            ]),
          ]),
        ),
      );
}

class SearchBox extends StatelessWidget {
  final String hint; final Color fill;
  const SearchBox(this.hint, {super.key, this.fill = fieldBg});
  @override
  Widget build(BuildContext context) => Container(
        height: 52, padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          const Icon(Icons.search, color: Colors.black45),
          const SizedBox(width: 8),
          Text(hint, style: ts(14, c: Colors.black45)),
        ]),
      );
}

// ───────── 1. Splash ─────────
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/register'),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [Color(0xFF3E6F86), Color(0xFF9A6C78), Color(0xFFEE746B)])),
            child: SafeArea(
              child: Stack(children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center,
                      children: [for (final h in [280.0, 380, 420, 330, 260, 220])
                        Container(width: 38, height: 0, margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(.12), borderRadius: BorderRadius.circular(6)))]),
                ),
                Column(children: [
                  const Spacer(flex: 3),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Logo(),
                    const SizedBox(width: 14),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('بيت الفكرة', style: GoogleFonts.cairo(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white)),
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
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(i == 0 ? 1 : .4)))]),
                  const SizedBox(height: 12),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.lock_outline, size: 14, color: Colors.white70),
                    const SizedBox(width: 6),
                    Text('SECURE INTELLIGENT HUB', style: ts(11, w: FontWeight.w600, c: Colors.white70).copyWith(letterSpacing: 1.5)),
                  ]),
                  const SizedBox(height: 14),
                ]),
              ]),
            ),
          ),
        ),
      );
}

// ───────── 2. Register ─────────
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  Widget label(String en, String a) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(en, style: ts(14, w: FontWeight.w700, c: teal)), Text(a, style: ar(13))]));

  Widget field(String hint, {bool obscure = false, IconData? icon}) => TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint, hintStyle: ts(15, c: Colors.black38),
          prefixIcon: icon == null ? null : Icon(icon, color: Colors.black54),
          filled: true, fillColor: fieldBg, contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(24), children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CircleAvatar(backgroundColor: fieldBg, child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: teal, size: 20), onPressed: () => Navigator.pop(context))),
              const Logo(size: .4),
              const CircleAvatar(backgroundColor: fieldBg, child: Icon(Icons.language, color: teal)),
            ]),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: blueTag, borderRadius: BorderRadius.circular(20)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.circle, size: 9, color: brick), const SizedBox(width: 6),
                  Text('FEKRA HOUSE · بيت الفكرة', style: ts(12, w: FontWeight.w700, c: teal)),
                ]),
              ),
            ),
            const SizedBox(height: 14),
            Text('Create your account', style: ts(32, w: FontWeight.w800, c: Colors.black)),
            Text('Start scanning and organizing your documents effortlessly.', style: ts(13.5, c: Colors.black87)),
            label('Full Name', 'الاسم الكامل'), field('e.g. Tariq Mansour', icon: Icons.person_outline),
            label('Title / Role', 'المسمى الوظيفي'), field('e.g. Senior Architect / Project Lead', icon: Icons.work_outline),
            label('Phone Number', 'رقم الجوال'),
            Row(children: [
              Container(
                height: 58, padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: fieldBg, borderRadius: BorderRadius.circular(18)),
                child: Row(children: [
                  Container(width: 26, height: 18, color: const Color(0xFF1F8A45)), const SizedBox(width: 8),
                  Text('+966', style: ts(15)), const Icon(Icons.keyboard_arrow_down, size: 18),
                ]),
              ),
              const SizedBox(width: 10),
              Expanded(child: field('50 123 4567')),
            ]),
            label('Password', 'كلمة المرور'),
            field('••••••••••••', obscure: true, icon: Icons.lock_outline),
            const SizedBox(height: 12),
            Row(children: [
              for (final c in [brick, brick, Colors.black12])
                Expanded(child: Container(height: 4, margin: const EdgeInsets.only(right: 8), color: c)),
              Text('Moderate', style: ts(12, c: Colors.black54)),
            ]),
            const SizedBox(height: 14),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 20, height: 20, decoration: BoxDecoration(color: teal, borderRadius: BorderRadius.circular(5)),
                  child: const Icon(Icons.check, size: 14, color: Colors.white)),
              const SizedBox(width: 10),
              Expanded(child: Text('Protected with enterprise OCR encryption & biometric document safeguarding.', style: ts(11.5))),
            ]),
            const SizedBox(height: 20),
            GradBtn('Register →', colors: const [Color(0xFF3E6F86), teal, brick],
                onTap: () => Navigator.pushNamed(context, '/otp')),
            const SizedBox(height: 22),
            Center(child: Text.rich(TextSpan(text: 'Already have an account? ', style: ts(14), children: [
              TextSpan(text: 'Log in', style: ts(14, w: FontWeight.w700, c: brick))]))),
          ]),
        ),
      );
}

// ───────── 3. Verify OTP ─────────
class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const digits = ['4', '8', '2', '', '', ''];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CircleAvatar(backgroundColor: fieldBg, child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: teal, size: 20), onPressed: () => Navigator.pop(context))),
              const CircleAvatar(backgroundColor: fieldBg, child: Text('?', style: TextStyle(color: teal))),
            ]),
            const SizedBox(height: 10),
            Stack(alignment: Alignment.center, children: [
              Container(width: 120, height: 130, decoration: BoxDecoration(color: Colors.white,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(60), top: Radius.circular(12)))),
              const Logo(size: .6),
            ]),
            const SizedBox(height: 14),
            Text('FEKRA HOUSE • بيت الفكرة', style: ts(14, w: FontWeight.w700, c: teal)),
            const SizedBox(height: 6),
            Text('Verify your phone number', style: ts(25, w: FontWeight.w800, c: Colors.black)),
            const SizedBox(height: 6),
            Text.rich(TextSpan(text: "We've sent a 6-digit verification code to ", style: ts(12.5), children: [
              TextSpan(text: '+966 50 123 4567', style: ts(12.5, w: FontWeight.w800, c: Colors.black))])),
            const SizedBox(height: 6),
            Text('✏️ Edit number', style: ts(14, w: FontWeight.w700, c: brick)),
            const SizedBox(height: 18),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              for (var i = 0; i < 6; i++)
                Container(
                  width: 52, height: 52, alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i < 3 ? Colors.white : fieldBg, borderRadius: BorderRadius.circular(14),
                    border: i == 3 ? Border.all(color: teal) : null),
                  child: Text(digits[i], style: ts(22, w: FontWeight.w800, c: teal)),
                ),
            ]),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: fieldBg, borderRadius: BorderRadius.circular(18)),
              child: Row(children: [
                const CircleAvatar(radius: 18, backgroundColor: blueTag),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Resend code in', style: ts(11)), Text('00:30', style: ts(18, w: FontWeight.w800)),
                ]),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(14)),
                  child: Text('Resend SMS', style: ts(13, w: FontWeight.w700, c: Colors.black38)),
                ),
              ]),
            ),
            const SizedBox(height: 18),
            GradBtn('Verify →', colors: const [coral, brick], onTap: () => Navigator.pushReplacementNamed(context, '/home')),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3, childAspectRatio: 2.2, mainAxisSpacing: 10, crossAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (final k in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '☝', '0', '⌫'])
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: (k == '☝') ? Colors.transparent : fieldBg, borderRadius: BorderRadius.circular(14)),
                      child: Text(k, style: ts(22, w: FontWeight.w700)),
                    ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ───────── Shell with bottom nav ─────────
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int i = 0;
  final pages = const [HomeScreen(), FoldersScreen(), HistoryScreen(), ProfileScreen()];

  Widget item(int idx, IconData icon, String label) {
    final on = i == idx;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => i = idx),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: on ? teal : Colors.black54),
          Text(label, style: ts(11.5, w: on ? FontWeight.w700 : FontWeight.w500, c: on ? teal : Colors.black54)),
          Icon(Icons.circle, size: 5, color: on ? coral : Colors.transparent),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: i, children: pages),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            width: 68, height: 68,
            child: FloatingActionButton(
              backgroundColor: coral, shape: const CircleBorder(), elevation: 4,
              onPressed: () => Navigator.pushNamed(context, '/scan'),
              child: const Icon(Icons.document_scanner_outlined, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(height: 22),
        ]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white, shape: const CircularNotchedRectangle(), notchMargin: 8, height: 70,
          padding: EdgeInsets.zero,
          child: Row(children: [
            item(0, Icons.home_outlined, 'Home'),
            item(1, Icons.folder_open, 'Folders'),
            const Expanded(child: SizedBox()),
            item(2, Icons.history, 'History'),
            item(3, Icons.account_circle_outlined, 'Profile'),
          ]),
        ),
      );
}

// ───────── 4. Home ─────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget action(String t, String s, Color bgc, Color fg, IconData ic) => Expanded(
        child: Container(
          height: 118, padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: bgc, borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Icon(ic, color: fg, size: 28)),
            const Spacer(),
            Text(t, style: ts(16, w: FontWeight.w800, c: fg)),
            Text(s, style: ts(11, c: fg)),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) => ListView(padding: EdgeInsets.zero, children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 54, 20, 24),
          decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF3E6F86), Color(0xFFEE746B)]),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white30)),
                child: Text('EN | العربية', style: ts(13, c: Colors.white)),
              ),
              const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.notifications_none, color: Colors.white)),
            ]),
            const SizedBox(height: 16),
            Text('Hello, Tariq 👋', style: ts(28, w: FontWeight.w800, c: Colors.white)),
            Row(children: [
              const Icon(Icons.circle, size: 8, color: Color(0xFFE8E08A)), const SizedBox(width: 6),
              Text('Senior Project Architect', style: ts(13, c: Colors.white)),
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
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              action('Upload Files', 'PDF, Docs, Images', sand, const Color(0xFF55552A), Icons.cloud_upload_outlined),
              const SizedBox(width: 12),
              action('Scan Images', 'Auto-edge detect', pink, brick, Icons.crop_free),
            ]),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFF1E6E3), borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                Container(width: 38, height: 38, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8))),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Al-Nakheel Masterplan 2025', style: ts(14.5, w: FontWeight.w800, c: Colors.black)),
                  Text('48 blueprints • Synced 6m ago', style: ts(11.5, c: Colors.black54)),
                ])),
                const CircleAvatar(radius: 15, backgroundColor: blueTag, child: Text('T', style: TextStyle(fontSize: 12))),
                const SizedBox(width: 4),
                const CircleAvatar(radius: 15, backgroundColor: pink, child: Text('S', style: TextStyle(fontSize: 12))),
              ]),
            ),
            const SizedBox(height: 18),
            Row(children: [
              Container(width: 4, height: 22, color: coral), const SizedBox(width: 8),
              Text('Recent Files', style: ts(19, w: FontWeight.w800, c: Colors.black)),
              const Spacer(),
              Text('See all >', style: ts(13, w: FontWeight.w700, c: brick)),
            ]),
            const SizedBox(height: 12),
            const FileTile('Contract_Villa_AlNakheel_Signe...', 'Architecture Projects', sand, 'Today, 11:20 AM · 2.4 MB'),
            const FileTile('Structural_Inspection_Report_v2...', 'Site Inspections', pink, 'Yesterday, 4:45 PM · 5.1 MB'),
            const FileTile('Municipality_Permits_2025.pdf', 'Legal & Permits', blueTag, 'May 12, 2025 · 1.8 MB'),
            Card2(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Vault Storage', style: ts(14, w: FontWeight.w800, c: teal)),
                  Text('14.8 GB of 50 GB', style: ts(12, c: Colors.black54)),
                ]),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Row(children: [
                    Expanded(flex: 5, child: Container(height: 8, color: teal)),
                    Expanded(flex: 3, child: Container(height: 8, color: coral)),
                    Expanded(flex: 2, child: Container(height: 8, color: olive)),
                    Expanded(flex: 1, child: Container(height: 8, color: Colors.black12)),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 40),
          ]),
        ),
      ]);
}

// ───────── 5. Folders ─────────
class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  Widget chip(String t, {bool on = false, Color? c}) => Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(color: on ? teal : (c ?? fieldBg), borderRadius: BorderRadius.circular(20)),
        child: Text(t, style: ts(13.5, w: FontWeight.w700, c: on ? Colors.white : (c != null ? brick : Colors.black87))),
      );

  Widget folder(String n, String meta, Color bgc, Color fg) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: bgc, borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.folder_outlined, color: fg)),
            const Icon(Icons.more_vert, size: 18, color: Colors.black45),
          ]),
          const Spacer(),
          Text(n, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(15, w: FontWeight.w800, c: Colors.black)),
          Text(meta, style: ts(11.5, c: Colors.black54)),
        ]),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Folders', style: ts(32, w: FontWeight.w800, c: teal)),
                Text('4 active categories • 47 files', style: ts(12, c: Colors.black54)),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(color: coral, borderRadius: BorderRadius.circular(22)),
                child: Row(children: [
                  const Icon(Icons.create_new_folder_outlined, color: Colors.white), const SizedBox(width: 6),
                  Text('New Folder', style: ts(15, w: FontWeight.w800, c: Colors.white)),
                ]),
              ),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              const Expanded(child: SearchBox('Search folders...')),
              const SizedBox(width: 10),
              Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black12)), child: const Icon(Icons.grid_view)),
              const SizedBox(width: 8),
              Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: fieldBg, borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.view_list)),
            ]),
            const SizedBox(height: 14),
            SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
              chip('All Folders  4', on: true), chip('Recent'), chip('Pinned'), chip('Simulate Empty', c: pink),
            ])),
            const SizedBox(height: 14),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: .98,
                children: [
                  folder('Architecture Projects', '18 files • 2 hrs ago', const Color(0xFFE3EAEE), teal),
                  folder('Site Inspections', '9 files • Yesterday', sand, olive),
                  folder('Legal & Permits', '14 files • May 10', const Color(0xFFFFEFB8), const Color(0xFF8A6A00)),
                  folder('Financial Invoices', '6 files • Apr 28', pink, brick),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12), margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(color: const Color(0xFFEFE9E5), borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.cloud_upload_outlined, color: teal)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Synced with بيت الفكرة Cloud', style: ts(13.5, w: FontWeight.w800, c: Colors.black)),
                  Text('3.4 GB of 15 GB utilized', style: ts(11.5, c: Colors.black54)),
                ])),
                const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.sync, color: teal)),
              ]),
            ),
          ]),
        ),
      );
}

// ───────── 6. Scan ─────────
class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  Widget thumb(Color c, {Widget? child}) => Container(
        width: 74, height: 66, alignment: Alignment.center,
        decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(10)), child: child);

  Widget tip(String t, String s, Color bgc) => Expanded(
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
                const CircleAvatar(backgroundColor: teal, child: Icon(Icons.flash_on, color: Colors.white)),
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFF1F323F), borderRadius: BorderRadius.circular(24)),
              child: Row(children: [
                const Icon(Icons.folder_outlined, color: coral, size: 20), const SizedBox(width: 8),
                Text('Architecture Projects', style: ts(15, w: FontWeight.w800, c: Colors.white)),
                const Spacer(),
                Text('Change', style: ts(13, w: FontWeight.w800, c: coral)),
              ]),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(color: const Color(0xFF7A6A5A), border: Border.all(color: coral, width: 1)),
                child: Stack(children: [
                  Center(child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                    child: Text('A4 Document Detected', style: ts(13, c: Colors.white)))),
                  Positioned(right: 10, bottom: 10, child: Container(
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
                  thumb(Colors.white), const SizedBox(width: 10),
                  thumb(const Color(0xFFE6EDF4)), const SizedBox(width: 10),
                  thumb(const Color(0xFF506573), child: const Icon(Icons.add, color: Colors.white)),
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
                    child: Container(decoration: const BoxDecoration(shape: BoxShape.circle, color: coral),
                        child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30)),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(color: coral, borderRadius: BorderRadius.circular(28)),
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
              color: bg, padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 4, height: 20, color: teal), const SizedBox(width: 8),
                  Text('Scan Settings & Tips', style: ts(16, w: FontWeight.w800, c: teal)),
                  const Spacer(), Text('Capture بيت الفكرة', style: ar(12, c: teal)),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  tip('Smart OCR Ready', 'Bilingual Arabic & English...', teal), const SizedBox(width: 12),
                  tip('Target Sync', 'Direct upload to Architecture...', const Color(0xFF9AAB6B)),
                ]),
              ]),
            ),
          ]),
        ),
      );
}

// ───────── 7. History ─────────
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Widget section(String t, Color dot, String count) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(children: [
          Icon(Icons.circle, size: 10, color: dot), const SizedBox(width: 8),
          Text(t, style: ts(17, w: FontWeight.w800, c: Colors.black)),
          const Spacer(), Text(count, style: ts(12, c: Colors.black54)),
        ]),
      );

  Widget pill(IconData ic, String t, Color bgc, Color fg) => Expanded(
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
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Logo(size: .45),
            Text('History', style: ts(15, c: Colors.black54)),
            Row(children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5)),
                  child: const Icon(Icons.search, size: 18)),
              const SizedBox(width: 10),
              const CircleAvatar(radius: 18, backgroundColor: teal, child: Icon(Icons.person_outline, color: Colors.white, size: 20)),
            ]),
          ]),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: teal, borderRadius: BorderRadius.circular(24)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('5 Archival Records', style: ts(21, w: FontWeight.w800, c: Colors.white)),
                const SizedBox(height: 4),
                Text('Synced across 3 projects • 15.3 MB total', style: ts(12, c: Colors.white70)),
              ])),
              const CircleAvatar(radius: 28, backgroundColor: Colors.white12, child: Icon(Icons.cloud_outlined, color: Colors.white70, size: 28)),
            ]),
          ),
          const SizedBox(height: 14),
          Row(children: [
            pill(Icons.calendar_today, 'Date: Last 30 Days', teal, Colors.white), const SizedBox(width: 10),
            pill(Icons.folder_outlined, 'Folder: All Folders', sand, const Color(0xFF55552A)),
          ]),
          section('Today', coral, '2 scans'),
          const FileTile('Contract_Villa_AlNakheel_Sign...', 'Architecture Projects', blueTag, '2.4 MB', time: '11:20 AM'),
          const FileTile('Site_Photos_Foundation_Check...', 'Site Inspections', sand, '4.8 MB', time: '09:15 AM'),
          section('Yesterday', Colors.black, '2 scans'),
          const FileTile('Structural_Inspection_Report_v...', 'Site Inspections', sand, '5.1 MB', time: '4:45 PM'),
          const FileTile('Vendor_Agreement_Draft.pdf', 'Legal & Permits', Color(0xFFEBDCDA), '1.2 MB', time: '02:10 PM'),
          section('May 12, 2025', Colors.black26, '1 scan'),
          const SizedBox(height: 40),
        ]),
      );
}

// ───────── 8. Profile ─────────
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget cred(String l, String v) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card2(
          pad: const EdgeInsets.all(12),
          child: Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: fieldBg, borderRadius: BorderRadius.circular(12))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l, style: ts(11.5, c: Colors.black54)),
              Text(v, style: ts(16, w: FontWeight.w800, c: Colors.black)),
            ])),
            CircleAvatar(radius: 17, backgroundColor: fieldBg, child: const Icon(Icons.copy, size: 16, color: Colors.black54)),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Logo(size: .45),
            Text('Profile', style: ts(20, w: FontWeight.w800, c: teal)),
            const Icon(Icons.circle_outlined, color: teal),
          ]),
          const SizedBox(height: 14),
          Card2(
            pad: const EdgeInsets.all(14),
            child: Column(children: [
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: 78, height: 78, alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: coral, width: 4)),
                  child: Text('TM', style: ts(26, w: FontWeight.w800, c: teal)),
                ),
                Positioned(right: -4, bottom: -4, child: Container(width: 24, height: 24, decoration: const BoxDecoration(color: coral, shape: BoxShape.circle))),
              ]),
              const SizedBox(height: 10),
              Text('Tariq Mansour', style: ts(21, w: FontWeight.w800, c: Colors.black)),
              Text('Bilingual Workspace Member', style: ts(12, c: Colors.black54)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity, padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: fieldBg, borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  Text('Senior Project Architect', style: ts(16, c: teal)),
                  Text('Tap to edit title', style: ts(10.5, c: Colors.black45)),
                ]),
              ),
              const SizedBox(height: 10),
              GradBtn('Save changes', colors: const [coral, coral]),
            ]),
          ),
          const SizedBox(height: 14),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Verified Credentials', style: ts(14, w: FontWeight.w800, c: teal)),
            Text('Read-only Identity', style: ts(11, c: Colors.black54)),
          ]),
          const SizedBox(height: 8),
          cred('Full Name', 'Tariq Mansour'),
          cred('Phone Number', '+966 50 123 4567'),
          cred('Organization / Firm', 'Dar Al-Handasah Studio'),
          const SizedBox(height: 14),
          Container(
            height: 56, alignment: Alignment.center,
            decoration: BoxDecoration(color: const Color(0xFFEFE9E5), borderRadius: BorderRadius.circular(18)),
            child: Text('Log out', style: ts(17, w: FontWeight.w800, c: teal)),
          ),
          const SizedBox(height: 8),
          Center(child: Text('🗑️ Delete account', style: ts(13, c: brick))),
          const SizedBox(height: 30),
        ]),
      );
}
