import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';

class SauNotificationsModal extends StatefulWidget {
  const SauNotificationsModal({
    Key? key,
  }) : super(key: key);

  @override
  State<SauNotificationsModal> createState() => _SauNotificationsModalState();
}

class _SauNotificationsModalState extends State<SauNotificationsModal> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    late bool notificationsEnabled = false;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Text(
            "Уведомления о сорах",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 12.h),
          Text(
            notificationsEnabled ? "Включены" : "Отключены",
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 18.sp,
              color: notificationsEnabled
                  ? theme.colorScheme.surfaceVariant
                  : theme.colorScheme.error,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Мы уведомляем вас о завтрашних сорах по вечерам, чтобы вы успели подготовиться",
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontSize: 15.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 25.h),
          CommonButton(
            text: notificationsEnabled
                ? "Выключить уведомления"
                : "Включить уведомления",
            onPressed: () {
              setState(() {
                notificationsEnabled = !notificationsEnabled;
              });
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
