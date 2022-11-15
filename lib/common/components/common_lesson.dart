import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';

class CommonLesson extends StatelessWidget {
  final Lesson lesson;

  const CommonLesson({
    Key? key,
    required this.lesson,
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
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Уч: ${lesson.teacher}",
              style: theme.textTheme.labelMedium,
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
                color: theme.colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Каб: ${lesson.cabinet.name}",
              style: theme.textTheme.labelMedium,
            )
          ],
        )
      ],
    );
  }
}
