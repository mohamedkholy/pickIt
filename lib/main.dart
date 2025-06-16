import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/di/dependency_injection.dart';
import 'package:pickit/core/routing/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      child: MaterialApp(
        onGenerateRoute: AppRouter.getRoutes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'PlusJakartaSans',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white),
        ),
      ),
    );
  }
}
