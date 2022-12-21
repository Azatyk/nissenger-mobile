import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_lesson.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_current_lesson_cubit/schedule_current_lesson_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_current_lesson_cubit/schedule_current_lesson_state.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_scroll_cubit/schedule_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_scroll_cubit/schedule_scroll_state.dart';

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

class _ScheduleDayState extends State<ScheduleDay> with WidgetsBindingObserver {
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(scrollListener);

    BlocProvider.of<ScheduleScrollCubit>(context).reachTop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToTop();
    });

    WidgetsBinding.instance.addObserver(this);
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 1),
        curve: Curves.bounceInOut,
      );
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void scrollToTop() {
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 1),
      curve: Curves.bounceInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<ScheduleCurrentLessonCubit, ScheduleCurrentLessonState>(
        builder: (context, state) {
      if (widget.dayLessons.isNotEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: ListView.separated(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                  bottom: index == widget.dayLessons.length - 1 ? 24.h : 0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: widget.dayLessons[index].window ? 6.h : 18.h),
                child: CommonLesson(
                  lesson: widget.dayLessons[index],
                  active: state is ScheduleCurrentLessonIndex &&
                      state.index == index &&
                      widget.todayLessons,
                ),
              ),
            ),
            separatorBuilder: (context, index) =>
                (widget.dayLessons[index].window ||
                        (index != widget.dayLessons.length - 1 &&
                            widget.dayLessons[index + 1].window))
                    ? Container()
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        width: double.infinity,
                        height: 1.h,
                        color: theme.colorScheme.onBackground.withOpacity(0.7),
                      ),
            itemCount: widget.dayLessons.length,
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.only(bottom: 100.h),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.boxOpen,
                  color: theme.colorScheme.primary,
                  size: 36.sp,
                ),
                SizedBox(height: 14.h),
                Text(
                  "В этот день уроков нет",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
