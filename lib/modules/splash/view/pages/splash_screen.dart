import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_state.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_cubit.dart';
import 'package:nissenger_mobile/modules/splash/data/types/splash_status.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
      child: const SplashScreenContent(),
    );
  }
}

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    BlocProvider.of<SplashCubit>(context).initializeApp();

    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (prevState, newState) =>
          newState.status == SplashStatus.readyToPush,
      listener: (context, state) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const GreetingPage(),
          ),
        );
      },
      child: Container(
        color: theme.colorScheme.primary,
        child: Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}
