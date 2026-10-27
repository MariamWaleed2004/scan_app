import 'package:flutter/material.dart';
import 'package:fekra_house/config/routes/app_router.dart';
import 'package:fekra_house/config/routes/app_routes.dart';
import 'package:fekra_house/config/theme/app_theme.dart';

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
