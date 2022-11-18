import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';

class SupportMethodsModal extends StatelessWidget {
  const SupportMethodsModal({Key? key}) : super(key: key);

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
            "Связаться с нами",
            style: theme.textTheme.labelSmall,
          ),
          SizedBox(height: 16.h),
          Text(
            "Нашли баг, хотите предложить функционал или просто поболтать? Пишите нашему доброму боту в телеграм, а он передаст это нам",
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontSize: 15.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 45.h),
          CommonButton(
            text: "Написать в telegram",
            onPressed: () {},
          ),
          SizedBox(height: 35.h),
        ],
      ),
    );
  }
}
