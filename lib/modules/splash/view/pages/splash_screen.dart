import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_cubit.dart';
import 'package:nissenger_mobile/common/modals/support.modal.dart';
import 'package:nissenger_mobile/data/repositories/version.repository.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_state.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_cubit.dart';
import 'package:nissenger_mobile/modules/splash/view/components/splash_content.dart';
import 'package:nissenger_mobile/modules/timer/view/pages/timer_page.dart';
import 'package:nissenger_mobile/modules/update/view/pages/update_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(repository: VersionRepository()),
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
            builder: (context) => (state as SplashStateReadyToPush).update
                ? const UpdatePage()
                : state.authorized
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
        child: const Center(child: SplashContent()),
      ),
    );
  }
}
