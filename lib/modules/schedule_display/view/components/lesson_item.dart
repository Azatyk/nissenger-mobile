import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonItem extends StatefulWidget {
  final String lessonName;
  final String teacherName;
  final String time;
  final String classroom;

  const LessonItem(
      {required this.lessonName,
      required this.teacherName,
      required this.time,
      required this.classroom,
      super.key});

  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ListTile(
      title: Text(widget.lessonName,
          style: theme.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
      subtitle: Text(widget.teacherName,
          style: theme.textTheme.titleMedium?.copyWith(fontSize: 12.sp)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.time,
              style: theme.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
          SizedBox(height: 5.h,),
          Text(widget.classroom,
              style: theme.textTheme.titleMedium?.copyWith(fontSize: 12.sp))
        ],
      ),
    );
  }
}
