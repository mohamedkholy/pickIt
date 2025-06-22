// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/di/dependency_injection.dart';
import 'package:pickit/core/routing/app_router.dart';
import 'package:pickit/features/main/logic/main_cubit.dart';
import 'package:pickit/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => getIt<MainCubit>(),
        child: MaterialApp(
        onGenerateRoute: AppRouter.getRoutes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'PlusJakartaSans',
          scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
