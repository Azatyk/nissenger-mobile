import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/timer/data/helpers/ticker.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_cubit.dart';
import 'package:nissenger_mobile/modules/timer/view/components/timer_page_back_button.dart';
import 'package:nissenger_mobile/modules/timer/view/components/timer_page_timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 28.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TimerPageBackButton(),
              SizedBox(height: 80.h),
              BlocProvider(
                create: (context) => TimerCubit(ticker: const Ticker()),
                child: const Center(
                  child: TimerPageTimer(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
