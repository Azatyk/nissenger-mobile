import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/data/repositories/schedule.repository.dart';
import 'package:nissenger_mobile/helpers/ticker.dart';
import 'package:nissenger_mobile/modules/timer/data/short_lessons_list_cubit/short_lessons_list_cubit.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_cubit.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_state.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_hive_cubit/timer_hive_cubit.dart';
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
          create: (context) => TimerHiveCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ShortLessonsListCubit(repository: ScheduleRepository()),
        ),
      ],
      child: const TimerPageContent(),
    );
  }
}

class TimerPageContent extends StatefulWidget {
  const TimerPageContent({Key? key}) : super(key: key);

  @override
  State<TimerPageContent> createState() => _TimerPageContentState();
}

class _TimerPageContentState extends State<TimerPageContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    BlocProvider.of<TimerHiveCubit>(context).saveActiveMode();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<TimerCubit>(context).stopTimer();
      BlocProvider.of<ShortLessonsListCubit>(context).loadSchedule();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
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
