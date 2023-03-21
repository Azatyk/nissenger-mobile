import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_lesson.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/helpers/error_messages.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/relogin/view/pages/relogin_page.dart';
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
      listener: (context, state) {
        if (state is ShortLessonsListRequestData) {
          BlocProvider.of<TimerCubit>(context).setTimer(
            schedule: state.schedule,
          );
        } else if (state is ShortLessonsListNotFoundError) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ReloginPage(),
            ),
            (route) => false,
          );
        } else if (state is ShortLessonsListInternetConnectionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackbar(
              text: LangKeys.noInternetConnection.translate(context),
              theme: theme,
            ),
          );
        }
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
                  state.titleMonday
                      ? LangKeys.onMonday.translate(context)
                      : state.type == ShortLessonsListTypes.beforeLessons
                          ? LangKeys.willBeToday.translate(context)
                          : state.type == ShortLessonsListTypes.afterLessons
                              ? LangKeys.willBeTomorrow.translate(context)
                              : state.type ==
                                      ShortLessonsListTypes.duringLessons
                                  ? LangKeys.present.translate(context)
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
                            state.activeLessonIndex == index && state.isTimeout,
                        active: state.activeLessonIndex == index &&
                            !state.isTimeout,
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 30.h),
                      itemCount: state.threeLessons.length,
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
                Text(
                  state.numberOfRemainedLessons <= 0
                      ? LangKeys.lastLessons.translate(context)
                      : "${LangKeys.and.translate(context)} ${state.numberOfRemainedLessons} ${state.numberOfRemainedLessons == 1 ? LangKeys.lesson.translate(context) : state.numberOfRemainedLessons >= 2 && state.numberOfRemainedLessons <= 4 ? LangKeys.lessonSingle.translate(context) : LangKeys.lessonPlural.translate(context)} до ${state.lastLessonEndTime.endTimeHour.toString().padLeft(2, "0")}:${state.lastLessonEndTime.endTimeMinute.toString().padLeft(2, "0")}",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 12.sp,
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          );
        } else if (state is ShortLessonsListTommorowEmpty) {
          return Container(
            width: double.infinity,
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
                  LangKeys.willBeTomorrow.translate(context),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  LangKeys.noLessonsForTomorrow.translate(context),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 325.h,
            child: Container(
              decoration: containerStyles,
              child: ErrorBlock(
                errorType: state is ShortLessonsListInternetConnectionError
                    ? ErrorTypes.internetConnectionError
                    : ErrorTypes.unknownError,
                onMainButtonPressed: () {
                  BlocProvider.of<ShortLessonsListCubit>(context)
                      .loadSchedule();
                },
                secondaryButton: true,
              ),
            ),
          );
        }
      },
    );
  }
}
