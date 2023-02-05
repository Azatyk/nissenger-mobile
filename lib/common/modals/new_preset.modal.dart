import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/pages/grade_choice_page.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/pages/teachers_choice_page.dart';

class NewPreset extends StatelessWidget {
  const NewPreset({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Text(
            "Новый пресет",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            "Пресет какого расписания вы хотите добавить?",
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontSize: 15.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 30.h),
          Column(
            children: [
              CommonButton(
                secondary: true,
                text: "Расписание класса",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GradeChoicePage(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CommonButton(
                secondary: true,
                text: "Расписание учителя",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TeachersChoicePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height:
                defaultTargetPlatform == TargetPlatform.android ? 35.h : 50.h,
          ),
        ],
      ),
    );
  }
}