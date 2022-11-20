import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_current_lesson_cubit/schedule_current_lesson_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_day_cubit/schedule_day_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_request_cubit/schedule_request_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_request_cubit/schedule_request_state.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_scroll_cubit/schedule_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/view/components/schedule_day.dart';
import 'package:nissenger_mobile/modules/schedule/view/components/schedule_header.dart';

class ScheduleLessons extends StatefulWidget {
  const ScheduleLessons({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleLessons> createState() => _ScheduleLessonsState();
}

class _ScheduleLessonsState extends State<ScheduleLessons>
    with WidgetsBindingObserver {
  late int activePageIndex;
  late PageController controller;

  @override
  void initState() {
    DateTime today = DateTime.now();

    switch (today.weekday) {
      case DateTime.monday:
        activePageIndex = 0;
        break;
      case DateTime.tuesday:
        activePageIndex = 1;
        break;
      case DateTime.wednesday:
        activePageIndex = 2;
        break;
      case DateTime.thursday:
        activePageIndex = 3;
        break;
      case DateTime.friday:
        activePageIndex = 4;
        break;
      case DateTime.saturday:
        activePageIndex = 5;
        break;
      case DateTime.sunday:
        activePageIndex = 0;
        break;
    }

    controller = PageController(initialPage: activePageIndex);

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ScheduleRequestState scheduleRequestState =
          BlocProvider.of<ScheduleRequestCubit>(context).state;

      Schedule schedule = scheduleRequestState is ScheduleRequestData
          ? scheduleRequestState.schedule
          : const Schedule(
              days: [],
            );

      BlocProvider.of<ScheduleCurrentLessonCubit>(context).checkActiveLesson(
        todayLessons: schedule.days[DateTime.now().weekday - 1],
      );
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void navigateToPage() {
    controller.animateToPage(
      activePageIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocConsumer<ScheduleRequestCubit, ScheduleRequestState>(
        listenWhen: (prevState, newState) => newState is ScheduleRequestData,
        listener: (context, state) {
          int today = DateTime.now().weekday;
          if (today != 7) {
            BlocProvider.of<ScheduleCurrentLessonCubit>(context)
                .checkActiveLesson(
              todayLessons:
                  (state as ScheduleRequestData).schedule.days[today - 1],
            );
          }
        },
        builder: (context, state) {
          if (state is ScheduleRequestLoading) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SizedBox(
                  width: 40.r,
                  height: 40.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.w,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            );
          } else if (state is ScheduleRequestData) {
            return BlocProvider(
              create: (context) => ScheduleScrollCubit(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: ScheduleHeader(
                      activeDayIndex: activePageIndex,
                      onBackButtonClicked: () {
                        setState(() {
                          activePageIndex--;
                        });
                        navigateToPage();
                        BlocProvider.of<ScheduleDayCubit>(context).getDayTitle(
                          index: activePageIndex,
                        );
                      },
                      onNextButtonClicked: () {
                        setState(() {
                          activePageIndex++;
                        });
                        navigateToPage();
                        BlocProvider.of<ScheduleDayCubit>(context).getDayTitle(
                          index: activePageIndex,
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          activePageIndex = index;
                        });
                        BlocProvider.of<ScheduleDayCubit>(context).getDayTitle(
                          index: activePageIndex,
                        );
                      },
                      controller: controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.schedule.days.length,
                      itemBuilder: (context, index) => ScheduleDay(
                        todayLessons: index == (DateTime.now().weekday - 1),
                        dayLessons: state.schedule.days[index],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
