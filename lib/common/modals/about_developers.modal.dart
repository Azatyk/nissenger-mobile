import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

class AboutDevelopersModal extends StatelessWidget {
  const AboutDevelopersModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          child: Image.asset(
            "assets/images/about-developers-image.png",
            width: 1.sw,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  LangKeys.aboutTeam.translate(context),
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.surface,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  LangKeys.teamDescription.translate(context),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.surface,
                    fontSize: 15.sp,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 45.h),
                CommonButton(
                  text: LangKeys.ok.translate(context),
                  reverse: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: defaultTargetPlatform == TargetPlatform.android
                      ? 35.h
                      : 50.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
