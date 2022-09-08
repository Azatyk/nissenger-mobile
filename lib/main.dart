import "package:flutter/material.dart";
import 'package:nissenger_mobile/common/themes/light_theme.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      themeMode: ThemeMode.light,
      home: const GreetingPage(),
    );
  }
}
