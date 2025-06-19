import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickit/core/di/dependency_injection.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/features/chat/ui/chat_screen.dart';
import 'package:pickit/features/home/ui/home_screen.dart';
import 'package:pickit/features/login/logic/login_cubit.dart';
import 'package:pickit/features/login/ui/login_screen.dart';
import 'package:pickit/features/main/main_screen.dart';
import 'package:pickit/features/sign_up/logic/sign_up_cubit.dart';
import 'package:pickit/features/sign_up/ui/sign_up_screen.dart';

abstract class AppRouter {
  static Route? getRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (context) => MainScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.chat:
        return MaterialPageRoute(builder: (context) => ChatScreen());
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case Routes.signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: SignUpScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
