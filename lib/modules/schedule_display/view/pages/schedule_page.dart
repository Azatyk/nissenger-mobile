import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_current_lesson_cubit/schedule_current_lesson_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_day_cubit/schedule_day_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_request_cubit/schedule_request_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/events_button.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/page_header.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/schedule_lessons.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/timer_button.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 26.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PageHeader(),
                  SizedBox(height: 26.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Flexible(child: TimerButton()),
                      Flexible(child: EventsButton()),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ScheduleRequestCubit(),
                ),
                BlocProvider(
                  create: (context) => ScheduleDayCubit(),
                ),
                BlocProvider(
                  create: (context) => ScheduleCurrentLessonCubit(),
                )
              ],
              child: const Flexible(
                child: ScheduleLessons(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
