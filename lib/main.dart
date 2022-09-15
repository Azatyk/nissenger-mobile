import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/common/blocs/hive/hive_bloc.dart';
import 'package:nissenger_mobile/common/themes/light_theme.dart';
import 'package:nissenger_mobile/modules/onboarding/view/pages/onboarding_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HiveBloc>(
      lazy: false,
      create: (_) {
        return HiveBloc();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        themeMode: ThemeMode.light,
        home: const OnboardingPage(),
      ),
    );
  }
}
