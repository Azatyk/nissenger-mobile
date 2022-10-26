import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LessonsList extends StatefulWidget {
  const LessonsList({super.key});

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
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
            Text("Пн, 17 сентября", style: theme.textTheme.headlineSmall,),
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
      ],
    );
  }
}
