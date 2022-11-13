import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/day.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/lesson.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/lessons_list_view.dart';

class LessonsList extends StatefulWidget {
  final List<Day> daysList;

  const LessonsList({required this.daysList, super.key});

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  String daynum = "";
  String dayname = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  size: 14.sp,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {},
              ),
              Text(
                "Пн, 17 сентября",
                style: theme.textTheme.headlineSmall,
              ),
              CupertinoButton(
                child: FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: 14.sp,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 26.h,
          ),
          Expanded(
            child: PageView.builder(
              itemBuilder: ((context, index) {
                List<Lesson> lessonsList = widget.daysList[index].lessons;
                return LessonsListView(
                  lessonslist: lessonsList,
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
