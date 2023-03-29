import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/themes/light_theme.dart';
import 'package:nissenger_mobile/config/config.dart';
import 'package:nissenger_mobile/helpers/localization_service.dart';
import 'package:nissenger_mobile/modules/splash/view/pages/splash_screen.dart';
import 'config/preset_hive_class.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  AppMetrica.activate(AppMetricaConfig(Config.appMetricaKey));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // HttpOverrides.global = MyHttpOverrides();

  Hive.registerAdapter(PresetAdapter());

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  final localizationController = Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      init: localizationController,
      builder: (LocalizationController controller) {
        return ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (context, child) => MaterialApp(
            title: "Nissenger",
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            themeMode: ThemeMode.light,
            locale: controller.currentLanguage != ""
                ? Locale(controller.currentLanguage, "")
                : null,
            localeResolutionCallback:
                LocalizationService.localResolutionCallBack,
            supportedLocales: LocalizationService.supportedLocalesList,
            localizationsDelegates: LocalizationService.localizationsDelegate,
            home: const SplashScreen(),
          ),
        );
      },
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
