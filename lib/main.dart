// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/di/dependency_injection.dart';
import 'package:pickit/core/helpers/connection_observer.dart';
import 'package:pickit/core/routing/app_router.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/widgets/no_internet_layout.dart';
import 'package:pickit/features/main/logic/main_cubit.dart';
import 'package:pickit/firebase_options.dart';
import 'package:pickit/features/main/logic/theme_cubit.dart';
import 'package:pickit/core/models/connection_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MainCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectionState _connectionState = ConnectionState.connected;

  @override
  void initState() {
    context.read<ThemeCubit>().checkDarkMode(context);
    observeConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            builder: (context, child) {
              return Stack(
                children: [
                  child ?? SizedBox(),
                  if (_connectionState == ConnectionState.disconnected)
                    const NoInternetLayout(),
                ],
              );
            },
            onGenerateRoute: AppRouter.getRoutes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: MyColors(context).primaryColor,
              fontFamily: 'PlusJakartaSans',
              scaffoldBackgroundColor: MyColors(context).white,
              appBarTheme: AppBarTheme(color: MyColors(context).white),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: MyColors(context).white,
              ),
              colorScheme: ColorScheme.light(
                primary: MyColors(context).primaryColor,
                secondary: MyColors(context).secondaryColor,
              ),
            ),
            darkTheme: ThemeData(
              primaryColor: MyColors(context).primaryColor,
              fontFamily: 'PlusJakartaSans',
              scaffoldBackgroundColor: MyColors(context).white,
              appBarTheme: AppBarTheme(color: MyColors(context).white),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: MyColors(context).white,
              ),
              colorScheme: ColorScheme.dark(
                primary: MyColors(context).primaryColor,
                secondary: MyColors(context).secondaryColor,
              ),
            ),
            themeMode: state,
          );
        },
      ),
    );
  }

  void observeConnection() {
    ConnectionObserver.observeConnection((state) {
      setState(() {
        _connectionState = state;
      });
    });
  }
}
