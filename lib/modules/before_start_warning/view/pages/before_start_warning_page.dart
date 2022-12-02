import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/modules/before_start_warning/view/components/before_start_close_button.dart';
import 'package:nissenger_mobile/modules/before_start_warning/view/components/before_start_text.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/pages/grade_choice_page.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/pages/teachers_choice_page.dart';

class BeforeStartWarningPage extends StatelessWidget {
  final String userType;

  const BeforeStartWarningPage({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateNextPage() {
      if (userType == UserTypes.student) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const GradeChoicePage(),
          ),
        );
      } else if (userType == UserTypes.teacher) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TeachersChoicePage(),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFF3B8FE8),
                  Color(0xFF1F71C7),
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          top: 24.h,
                        ),
                        child: BeforeStartCloseButton(
                          onPressed: () {
                            navigateNextPage();
                          },
                        ),
                      ),
                      SizedBox(height: 38.h),
                      Flexible(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: const BeforeStartText(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 30.h,
                    left: 24.w,
                    right: 24.w,
                  ),
                  child: CommonButton(
                    text: "Понятно",
                    reverse: true,
                    onPressed: () {
                      navigateNextPage();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
