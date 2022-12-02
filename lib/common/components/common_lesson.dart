import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/variables/app_colors.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';

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
            "$lessonTitle ${lesson.classes?[0].number}${lesson.classes?[0].letter} класс";
        if (!lesson.joined) {
          lessonTitle = "$lessonTitle,  группа ${lesson.group}";
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

        lessonTitle = "${lesson.number}. Группа ${lesson.group}.  $lessonTitle  классы";
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        lessonTitle,
                        overflow: TextOverflow.ellipsis,
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
                          ? "Предмет: ${lesson.name}"
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
              ),
              SizedBox(width: 10.w),
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
