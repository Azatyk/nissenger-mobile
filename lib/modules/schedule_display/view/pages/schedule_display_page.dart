import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
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
              const LessonsList(),
            ],
          ),
        ),
      ),
    );
  }
}
