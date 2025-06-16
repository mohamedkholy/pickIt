import 'package:flutter/material.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/features/home/ui/home_screen.dart';
import 'package:pickit/features/main/main_screen.dart';

abstract class AppRouter {
  static Route? getRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (context) => MainScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return null;
    }
  }
}
