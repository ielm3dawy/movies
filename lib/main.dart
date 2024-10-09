import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/page_route_names.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'core/config/page_router.dart';
import 'core/config/theme_manager.dart';
import 'core/services/service_locator.dart';

void main() {
  setup();
  runApp(
    BlocProvider(
      create: (context) => sl<MainLayoutCubit>(),
      child: const MyApp(),
    ),
  );
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
