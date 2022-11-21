import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_state.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_cubit.dart';
import 'package:nissenger_mobile/modules/timer/view/pages/timer_page.dart';

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
      listenWhen: (prevState, newState) => newState is SplashStateReadyToPush,
      listener: (context, state) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => (state as SplashStateReadyToPush).authorized
                ? state.mode == AppModes.schedule
                    ? const SchedulePage()
                    : state.mode == AppModes.timer
                        ? const TimerPage()
                        : Container()
                : const GreetingPage(),
          ),
        );
      },
      child: Container(
        color: theme.colorScheme.primary,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60.r,
                height: 60.r,
                child: CircularProgressIndicator(
                  strokeWidth: 4.r,
                  color: theme.colorScheme.surface,
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "Загружаем расписание",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
