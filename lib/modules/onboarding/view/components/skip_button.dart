import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/pages/grade_choice_page.dart';
import 'package:nissenger_mobile/modules/teachers_search/view/pages/teachers_search_page.dart';

class SkipButton extends StatelessWidget {
  final bool slides;

  const SkipButton({required this.slides, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    void navigateToStudentsPage() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const GradeChoicePage(),
        ),
      );
    }

    void navigateToTeachersPage() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const TeachersSearchPage(),
        ),
      );
    }

    return CupertinoButton(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 18.h,
      ),
      color: Colors.transparent,
      onPressed: slides ? () {
        navigateToStudentsPage();
      } : () {
        navigateToTeachersPage();
      } ,
      child: Text(
        "Пропустить",
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
