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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${lesson.number}. ${lesson.name}",
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
              "Уч: ${lesson.teacher}",
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
              "Каб: ${lesson.cabinet.name}",
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
