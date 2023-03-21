import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/variables/app_colors.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/helpers/lesson_time.dart';

class CommonLesson extends StatelessWidget {
  final Lesson lesson;
  final bool active;
  final bool complete;
  final bool teacher;

  const CommonLesson({
    Key? key,
    required this.lesson,
    required this.active,
    this.complete = false,
    this.teacher = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String lessonTitle = "";
    if (lesson.classes != null) {
      if (lesson.classes?.length == 1) {
        lessonTitle = "${lesson.number}. ";
        lessonTitle =
            "$lessonTitle ${lesson.classes?[0].number}${lesson.classes?[0].letter} ${LangKeys.grade.translate(context)}";
        if (!lesson.joined) {
          lessonTitle =
              "$lessonTitle,  ${LangKeys.group.translate(context)} ${lesson.group}";
        }
      } else {
        for (int i = 0; i < lesson.classes!.length; i++) {
          lessonTitle = lessonTitle +
              lesson.classes![i].number.toString() +
              lesson.classes![i].letter;
          if (i != lesson.classes!.length - 1) {
            lessonTitle = "$lessonTitle, ";
          }
        }

        lessonTitle =
            "${lesson.number}. ${LangKeys.groupCapital.translate(context)} ${lesson.group}.  $lessonTitle  ${LangKeys.grades.translate(context)}";
      }
    } else {
      lessonTitle = "${lesson.number}. $lessonTitle ${lesson.name}";
    }

    return lesson.window
        ? Container(
            width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(
              color: active
                  ? theme.colorScheme.onPrimary.withOpacity(0.4)
                  : theme.colorScheme.onBackground.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                LangKeys.window.translate(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.sp,
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        lessonTitle,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: 14.sp,
                          color: active
                              ? theme.colorScheme.primary
                              : complete
                                  ? AppColors.success
                                  : theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      lesson.group != null
                          ? "${LangKeys.subject.translate(context)} ${lesson.name}"
                          : "${LangKeys.teach.translate(context)} ${lesson.teacher}",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: active
                            ? theme.colorScheme.primary
                            : complete
                                ? AppColors.success
                                : theme.colorScheme.onSecondary,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    LessonTimeText.time(
                      startTimeHour: lesson.time.startTimeHour,
                      startTimeMinute: lesson.time.startTimeMinute,
                      endTimeHour: lesson.time.endTimeHour,
                      endTimeMinute: lesson.time.endTimeMinute,
                    ),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: active
                          ? theme.colorScheme.primary
                          : complete
                              ? AppColors.success
                              : theme.colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Каб: ${lesson.cabinet.name != "" ? lesson.cabinet.name : "-"}",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: active
                          ? theme.colorScheme.primary
                          : complete
                              ? AppColors.success
                              : theme.colorScheme.onSecondary,
                    ),
                  )
                ],
              )
            ],
          );
  }
}
