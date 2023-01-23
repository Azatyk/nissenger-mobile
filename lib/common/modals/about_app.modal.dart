import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/config/config.dart';

class AboutAppModal extends StatelessWidget {
  const AboutAppModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final String version =
        "Версия приложения: ${Config.majorVersion}.${Config.minorVersion}.${Config.patchVersion}";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Text(
            "О приложении",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            "Мы получаем расписание с сайта «fmalmnis.edupage.org» и обновляем его каждую ночь, поэтому в приложении вы видите всегда актуальную версию расписания.",
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontSize: 15.sp,
              height: 1.6,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              version,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSecondary.withOpacity(0.5),
                fontSize: 15.sp,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(height: 45.h),
          CommonButton(
            text: "Понятно",
            onPressed: () {
              Navigator.of(context).pop();
            },
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
