import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

class ChangeGroupModal extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const ChangeGroupModal({
    Key? key,
    required this.onButtonPressed,
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
            LangKeys.changeGroupQuestion.translate(context),
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            LangKeys.changeDescription.translate(context),
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontSize: 15.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 45.h),
          CommonButton(
            text: LangKeys.changeGroup.translate(context),
            onPressed: onButtonPressed,
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
