import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/variables/app_colors.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';

class CommonLesson extends StatelessWidget {
  final Lesson lesson;
  final bool active;
  final bool complete;

  const CommonLesson({
    Key? key,
    required this.lesson,
    required this.active,
    this.complete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String lessonTitle = "${lesson.number}. ";
    if (lesson.window) {
      lessonTitle = "$lessonTitle Окно";
    } else if (lesson.classes != null) {
      if (lesson.classes?.length == 1) {
        lessonTitle = "$lessonTitle ${lesson.classes?[0]} класс";
      } else {
        for (int i = 0; i < lesson.classes!.length; i++) {
          lessonTitle = lessonTitle + lesson.classes![i];
          if (i != lesson.classes!.length - 1) {
            lessonTitle = "$lessonTitle, ";
          }
        }

        lessonTitle = "$lessonTitle  классы";
      }
    } else {
      lessonTitle = "$lessonTitle ${lesson.name}";
    }

    return lesson.window
        ? Container(
            width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.onBackground.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                "Окно",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.sp,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lessonTitle,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 14.sp,
                      color: active
                          ? theme.colorScheme.primary
                          : complete
                              ? AppColors.success
                              : theme.colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    lesson.group != null
                        ? "Группа: ${lesson.group}"
                        : "Уч: ${lesson.teacher}",
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${lesson.time.startTimeHour.toString().padLeft(2, "0")}:${lesson.time.startTimeMinute.toString().padLeft(2, "0")} — ${lesson.time.endTimeHour.toString().padLeft(2, "0")}:${lesson.time.endTimeMinute.toString().padLeft(2, "0")}",
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
