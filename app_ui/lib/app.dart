import 'package:app_ui/core/router/app_router.dart';
import 'package:app_ui/core/router/app_routes.dart';
import 'package:app_ui/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FekraApp extends StatelessWidget {
  const FekraApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.splash,
        routes: AppRouter.routes,
      );
}
