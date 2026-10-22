import 'app_routes.dart';

class AppRouter {
  AppRouter._();
  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.splash: (_) => const SplashPage(),
    AppRoutes.register: (_) => const RegisterPage(),
    AppRoutes.otp: (_) => const OtpPage(),
    AppRoutes.home: (_) => const MainShell(),
    AppRoutes.scan: (_) => const ScanPage(),
  };
}
