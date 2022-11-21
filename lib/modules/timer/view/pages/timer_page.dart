import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/timer/data/helpers/ticker.dart';
import 'package:nissenger_mobile/modules/timer/data/short_lessons_list_cubit/short_lessons_list_cubit.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_cubit.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_state.dart';
import 'package:nissenger_mobile/modules/timer/data/types/timer_types.dart';
import 'package:nissenger_mobile/modules/timer/view/components/short_lessons_list.dart';
import 'package:nissenger_mobile/modules/timer/view/components/timer_page_back_button.dart';
import 'package:nissenger_mobile/modules/timer/view/components/timer_page_timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TimerCubit(ticker: const Ticker()),
        ),
        BlocProvider(
          create: (context) => ShortLessonsListCubit(),
        ),
      ],
      child: const TimerPageContent(),
    );
  }
}

class TimerPageContent extends StatelessWidget {
  const TimerPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) => Scaffold(
        backgroundColor: (state is TimerDiactive &&
                state.type == TimerDiactiveTypes.beforeLessons)
            ? const Color(0xFFFF9F43)
            : (state is TimerDiactive &&
                    state.type == TimerDiactiveTypes.afterLessons)
                ? const Color(0xFF1EAE62)
                : theme.colorScheme.primary,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
              vertical: 28.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TimerPageBackButton(),
                    SizedBox(height: 80.h),
                    const Center(
                      child: TimerPageTimer(),
                    ),
                  ],
                ),
                const Flexible(
                  child: ShortLessonsList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
