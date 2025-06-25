import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickit/core/di/dependency_injection.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/features/chat/logic/chat_cubit.dart';
import 'package:pickit/features/chat/ui/chat_screen.dart';
import 'package:pickit/features/chats/data/models/chat.dart';
import 'package:pickit/features/home/ui/home_screen.dart';
import 'package:pickit/features/item_details/ui/item_details_screen.dart';
import 'package:pickit/features/login/logic/login_cubit.dart';
import 'package:pickit/features/login/ui/login_screen.dart';
import 'package:pickit/features/main/ui/main_screen.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/sign_up/logic/sign_up_cubit.dart';
import 'package:pickit/features/sign_up/ui/sign_up_screen.dart';

abstract class AppRouter {
  static Route? getRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.chat:
        final chat = args as Chat;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => getIt<ChatCubit>(),
                child: ChatScreen(chat: chat),
              ),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: const LoginScreen(),
              ),
        );
      case Routes.signup:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => getIt<SignUpCubit>(),
                child: const SignUpScreen(),
              ),
        );
      case Routes.itemDetails:
        final item = args as Item;
        return MaterialPageRoute(
          builder: (context) => ItemDetailsScreen(item: item),
        );
      default:
        return null;
    }
  }
}
