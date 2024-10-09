import 'package:flutter/material.dart';
import 'package:movies_app/core/config/page_route_names.dart';
import 'package:movies_app/features/main_layout/presentation/categories/selected_category_screen.dart';
import 'package:movies_app/features/main_layout/presentation/main_layout.dart';
import 'package:movies_app/features/splash_screen/splash_screen.dart';

import '../../features/main_layout/presentation/movie_screen/movie_details_screen.dart';

class PageRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteNames.init:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );

      case PageRouteNames.mainLayout:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(),
          settings: settings,
        );

      case PageRouteNames.selectedCategoryScreen:
        return MaterialPageRoute(
          builder: (context) => const SelectedCategoryScreen(),
          settings: settings,
        );

      case PageRouteNames.movieDetailedScreen:
        return MaterialPageRoute(
          builder: (context) => const MovieDetailsScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
