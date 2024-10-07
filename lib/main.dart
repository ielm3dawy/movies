import 'package:flutter/material.dart';
import 'package:movies_app/core/config/page_route_names.dart';
import 'core/config/page_router.dart';
import 'core/config/theme_manager.dart';
import 'core/services/service_locator.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      themeMode: ThemeMode.dark,
      darkTheme: ApplicationThemeManager.darkTheme,
      initialRoute: PageRouteNames.init,
      onGenerateRoute: PageRouter.onGenerateRoute,
    );
  }
}