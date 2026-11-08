import 'package:flutter/widgets.dart';
import 'package:fekra_house/app.dart';
import 'package:fekra_house/core/services/locator/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const FekraApp());
}
