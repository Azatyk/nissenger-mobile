import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_lesson.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_current_lesson_cubit/schedule_current_lesson_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_current_lesson_cubit/schedule_current_lesson_state.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_scroll_cubit/schedule_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_scroll_cubit/schedule_scroll_state.dart';

class ScheduleDay extends StatefulWidget {
  final List<Lesson> dayLessons;
  final bool todayLessons;

  const ScheduleDay({
    Key? key,
    required this.dayLessons,
    required this.todayLessons,
  }) : super(key: key);

  @override
  State<ScheduleDay> createState() => _ScheduleDayState();
}

class _ScheduleDayState extends State<ScheduleDay> {
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    var currentState = context.read<ScheduleScrollCubit>().state;

    if (controller.offset > controller.position.minScrollExtent &&
        !controller.position.outOfRange &&
        currentState is ScheduleScrollHideBorder) {
      BlocProvider.of<ScheduleScrollCubit>(context, listen: false)
          .scrollToBottom();
    } else if (controller.offset <= controller.position.minScrollExtent &&
        currentState is ScheduleScrollShowBorder) {
      BlocProvider.of<ScheduleScrollCubit>(context, listen: false).reachTop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCurrentLessonCubit, ScheduleCurrentLessonState>(
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: ListView.builder(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: CommonLesson(
              lesson: widget.dayLessons[index],
              active: state is ScheduleCurrentLessonIndex &&
                  state.index == index &&
                  widget.todayLessons,
            ),
          ),
          itemCount: widget.dayLessons.length,
        ),
      ),
    );
  }
}
