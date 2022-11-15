import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_lesson.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';

class ScheduleDay extends StatelessWidget {
  final List<Lesson> dayLessons;

  const ScheduleDay({
    Key? key,
    required this.dayLessons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => CommonLesson(
          lesson: dayLessons[index],
        ),
        separatorBuilder: (context, index) => SizedBox(height: 30.h),
        itemCount: dayLessons.length,
      ),
    );
  }
}
