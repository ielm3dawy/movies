import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app/core/config/page_route_names.dart';
import 'package:movies_app/main.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // استخدام WidgetsBinding للتأكد من تنفيذ Timer بعد بناء الواجهة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, PageRouteNames.mainLayout);
      });
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/splash.png', // تأكد من أن مسار الصورة صحيح
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}