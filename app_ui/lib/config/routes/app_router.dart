import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/core/services/locator/service_locator.dart';
import 'package:fekra_house/features/auth/presentation/view_model/login_cubit.dart';
import 'package:fekra_house/features/auth/presentation/view_model/otp_cubit.dart';
import 'package:fekra_house/features/auth/presentation/view_model/register_cubit.dart';
import 'package:fekra_house/features/auth/presentation/views/screens/login_screen.dart';
import 'package:fekra_house/features/auth/presentation/views/screens/otp_screen.dart';
import 'package:fekra_house/features/auth/presentation/views/screens/register_screen.dart';
import 'package:fekra_house/features/documents/presentation/view_model/history_cubit.dart';
import 'package:fekra_house/features/documents/presentation/views/screens/history_screen.dart';
import 'package:fekra_house/features/folders/presentation/view_model/folders_cubit.dart';
import 'package:fekra_house/features/folders/presentation/views/screens/folders_screen.dart';
import 'package:fekra_house/features/home/presentation/view_model/home_cubit.dart';
import 'package:fekra_house/features/home/presentation/views/screens/home_screen.dart';
import 'package:fekra_house/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:fekra_house/features/profile/presentation/views/screens/profile_screen.dart';
import 'package:fekra_house/features/scan/presentation/views/screens/scan_screen.dart';
import 'package:fekra_house/features/shell/presentation/views/screens/main_shell_screen.dart';
import 'package:fekra_house/features/splash/presentation/views/screens/splash_screen.dart';
import 'app_routes.dart';

/// Route table. Each Cubit is created (from the service locator) right next to
/// the screen that owns it, so BlocProvider owns and closes it.
class AppRouter {
  AppRouter._();

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.splash: (_) => const SplashScreen(),
    AppRoutes.login: (_) => BlocProvider(
          create: (_) => sl<LoginCubit>(),
          child: const LoginScreen(),
        ),
    AppRoutes.register: (_) => BlocProvider(
          create: (_) => sl<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
    AppRoutes.otp: (_) => BlocProvider(
          create: (_) => sl<OtpCubit>()..loadPhone(),
          child: const OtpScreen(),
        ),
    AppRoutes.home: (_) => MainShellScreen(
          tabs: [
            BlocProvider(create: (_) => sl<HomeCubit>()..load(), child: const HomeScreen()),
            BlocProvider(create: (_) => sl<FoldersCubit>()..load(), child: const FoldersScreen()),
            BlocProvider(create: (_) => sl<HistoryCubit>()..load(), child: const HistoryScreen()),
            BlocProvider(create: (_) => sl<ProfileCubit>()..load(), child: const ProfileScreen()),
          ],
        ),
    AppRoutes.scan: (_) => const ScanScreen(),
  };
}
