import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_lesson.dart';
import 'package:nissenger_mobile/modules/timer/data/short_lessons_list_cubit/short_lessons_list_cubit.dart';
import 'package:nissenger_mobile/modules/timer/data/short_lessons_list_cubit/short_lessons_list_state.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_cubit.dart';
import 'package:nissenger_mobile/modules/timer/data/types/short_lessons_list_types.dart';

class ShortLessonsList extends StatelessWidget {
  const ShortLessonsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    BoxDecoration containerStyles = BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14.r),
    );

    return BlocConsumer<ShortLessonsListCubit, ShortLessonsListState>(
        listenWhen: (prevState, newState) =>
            newState is ShortLessonsListRequestData,
        listener: (context, state) {
          BlocProvider.of<TimerCubit>(context).setTimer(
            schedule: (state as ShortLessonsListRequestData).schedule,
          );
        },
        builder: (context, state) {
          if (state is ShortLessonsListRequestLoading) {
            return SizedBox(
              height: 325.h,
              child: Container(
                decoration: containerStyles,
                child: Center(
                  child: SizedBox(
                    width: 36.r,
                    height: 36.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 5.r,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is ShortLessonsListData) {
            return Container(
              decoration: containerStyles,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.type == ShortLessonsListTypes.beforeLessons
                        ? "Будут сегодня"
                        : state.type == ShortLessonsListTypes.afterLessons
                            ? "Будут завтра"
                            : state.type == ShortLessonsListTypes.duringLessons
                                ? "Идут сейчас"
                                : "",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => CommonLesson(
                          lesson: state.threeLessons[index],
                          complete: state.activeLessonIndex > index ||
                              state.activeLessonIndex == index &&
                                  state.isTimeout,
                          active: state.activeLessonIndex == index &&
                              !state.isTimeout,
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 22.h),
                        itemCount: state.threeLessons.length,
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    state.numberOfRemainedLessons <= 0
                        ? "Это последние уроки"
                        : "И ещё ${state.numberOfRemainedLessons} ${state.numberOfRemainedLessons == 1 ? "урок" : state.numberOfRemainedLessons >= 2 && state.numberOfRemainedLessons <= 4 ? "урока" : "уроков"} до ${state.lastLessonEndTime.endTimeHour.toString().padLeft(2, "0")}:${state.lastLessonEndTime.endTimeMinute.toString().padLeft(2, "0")}",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 12.sp,
                      color: theme.colorScheme.onSecondary,
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
