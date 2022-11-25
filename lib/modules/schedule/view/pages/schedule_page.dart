import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/data/repositories/schedule.repository.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_current_lesson_cubit/schedule_current_lesson_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_day_cubit/schedule_day_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_request_cubit/schedule_request_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_hive_cubit/schedule_hive_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/view/components/events_button.dart';
import 'package:nissenger_mobile/modules/schedule/view/components/free_cabinet_button.dart';
import 'package:nissenger_mobile/modules/schedule/view/components/page_header.dart';
import 'package:nissenger_mobile/modules/schedule/view/components/schedule_lessons.dart';
import 'package:nissenger_mobile/modules/schedule/view/components/timer_button.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleHiveCubit(),
      child: const ScheduleContentPage(),
    );
  }
}

class ScheduleContentPage extends StatefulWidget {
  const ScheduleContentPage({super.key});

  @override
  State<ScheduleContentPage> createState() => _ScheduleContentPageState();
}

class _ScheduleContentPageState extends State<ScheduleContentPage> {
  @override
  void initState() {
    BlocProvider.of<ScheduleHiveCubit>(context).getUserType();
    BlocProvider.of<ScheduleHiveCubit>(context).saveActiveMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userType = context.watch<ScheduleHiveCubit>().state.userType;

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
                    children: [
                      const Flexible(child: TimerButton()),
                      Flexible(
                        child: userType == UserTypes.student
                            ? const EventsButton()
                            : userType == UserTypes.teacher
                                ? const FreeCabinetButton()
                                : Container(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ScheduleRequestCubit(
                    repository: ScheduleRepository(),
                  ),
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
