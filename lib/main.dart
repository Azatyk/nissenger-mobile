import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/themes/light_theme.dart';
import 'package:nissenger_mobile/config/config.dart';
import 'package:nissenger_mobile/modules/splash/view/pages/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  AppMetrica.activate(AppMetricaConfig(Config.appMetricaKey));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // HttpOverrides.global = MyHttpOverrides();

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

// delete for prod
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
