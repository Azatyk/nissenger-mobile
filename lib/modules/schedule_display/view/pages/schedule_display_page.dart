import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/plain_data/list_days.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_request_cubit/schedule_request_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_request_cubit/schedule_request_state.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/day.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/scedule_status.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/events_button.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/lessons_list.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/page_header.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/timer_button.dart';

class ScheduleDisplayPage extends StatefulWidget {
  const ScheduleDisplayPage({super.key});

  @override
  State<ScheduleDisplayPage> createState() => _ScheduleDisplayPageState();
}

class _ScheduleDisplayPageState extends State<ScheduleDisplayPage> {
  List<Day> days = [];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocListener<ScheduleRequestCubit, ScheduleRequestState>(
      listenWhen: (prevState, newState) =>
          newState.status == ScheduleStatus.readyToPush,
      listener: (context, state) {
        BlocProvider.of<ScheduleRequestCubit>(context)
            .loadSchedule(daysList: daysList);
        days = state.listOfDays;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 28.w),
            child: Column(
              children: [
                const PageHeader(),
                SizedBox(
                  height: 26.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TimerButton(),
                    EventsButton(),
                  ],
                ),
                SizedBox(height: 40.h),
                LessonsList(daysList: days),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
