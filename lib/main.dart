import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/themes/light_theme.dart';
import 'package:nissenger_mobile/modules/splash/view/pages/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}
