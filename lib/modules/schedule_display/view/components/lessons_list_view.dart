import 'package:flutter/material.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/lesson.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/lesson_item.dart';

class LessonsListView extends StatefulWidget {
  final List<Lesson> lessonslist;

  const LessonsListView({required this.lessonslist, super.key});

  @override
  State<LessonsListView> createState() => _LessonsListViewState();
}

class _LessonsListViewState extends State<LessonsListView> {
  bool atTop = true;
  bool atBottom = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: atTop,
          child: const DashedDivider(),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                physics:
                    const ClampingScrollPhysics(), //BouncingScrollPhysics instead of ClampingScrollPhysics required
                // separatorBuilder: (context, index) {
                //   return const DashedDivider();
                // },
                itemCount: widget.lessonslist.length,
                itemBuilder: (context, index) {
                  int lessonNumber = index + 1;

                  return LessonItem(
                    // ignore: unnecessary_brace_in_string_interps
                    lessonName:
                        "${lessonNumber}. ${widget.lessonslist[index].lessonName}",
                    teacherName:
                        "Учитель: ${widget.lessonslist[index].teacherName}",
                    time:
                        "${widget.lessonslist[index].startTime} - ${widget.lessonslist[index].endTime}",
                    classroom: "Каб: ${widget.lessonslist[index].classroom}",
                  );
                },
              ),
            ),
            onNotification: (ScrollNotification notification) {
              if (notification.metrics.atEdge) {
                if (notification.metrics.pixels == 0) {
                  setState(() {
                    atTop = true;
                    atBottom = false;
                  });
                } else {
                  setState(() {
                    atBottom = true;
                    atTop = false;
                  });
                }
              }
              return true;
            },
          ),
        ),
        Visibility(
          visible: atBottom,
          child: const DashedDivider(),
        ),
      ],
    );
  }
}
