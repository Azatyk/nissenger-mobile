import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/common/themes/light_theme.dart';
import 'package:nissenger_mobile/modules/splash/data/bloc/splash_bloc.dart';
import 'package:nissenger_mobile/modules/splash/view/pages/splash_screen.dart';

import 'modules/splash/data/bloc/splash_event.dart';

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
      home: BlocProvider<SplashBloc>(
        create: (context) => SplashBloc()..add(const AppInitialized()),
        child: const SplashScreen(),
      ),
    );
  }
}
