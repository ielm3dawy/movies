import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/page_route_names.dart';
import 'package:movies_app/features/main_layout/presentation/categories/selected_category_screen.dart';
import 'package:movies_app/features/main_layout/presentation/main_layout.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'package:movies_app/features/splash_screen/splash_screen.dart';

import '../services/service_locator.dart';

class PageRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteNames.init:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );

      case PageRouteNames.mainLayout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<MainLayoutCubit>(
            create: (context) => sl<MainLayoutCubit>(),
            child: MainLayout(),
          ),
          settings: settings,
        );

      case PageRouteNames.selectedCategoryScreen:
        return MaterialPageRoute(
          builder: (context) => SelectedCategoryScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
    }
  }
}
