import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_rounded_button.dart';

class ErrorBlock extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool internetConnectionError;
  final String mainButtonText;
  final VoidCallback onMainButtonPressed;
  final bool secondaryButton;
  final String secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool reverseColor;

  const ErrorBlock({
    Key? key,
    required this.title,
    required this.subtitle,
    this.internetConnectionError = false,
    required this.mainButtonText,
    required this.onMainButtonPressed,
    this.secondaryButton = false,
    this.onSecondaryButtonPressed,
    this.secondaryButtonText = "",
    this.reverseColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (internetConnectionError)
          Padding(
            padding: EdgeInsets.only(bottom: 35.h),
            child: Align(
              child: Image.asset(
                "assets/images/wifi-off-icon.png",
                width: 50.w,
              ),
            ),
          ),
        SizedBox(
          width: 0.7.sw,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              color: reverseColor
                  ? theme.colorScheme.background
                  : theme.colorScheme.secondary,
            ),
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          width: 0.8.sw,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 15.sp,
              height: 1.45,
              color: reverseColor
                  ? theme.colorScheme.background
                  : theme.colorScheme.onSecondary,
            ),
          ),
        ),
        SizedBox(height: 32.h),
        CommonRoundedButton(
          text: mainButtonText,
          onPressed: onMainButtonPressed,
          reverseColor: reverseColor,
        ),
        if (secondaryButton)
          Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: CommonRoundedButton(
              reverseColor: !reverseColor,
              text: secondaryButtonText,
              onPressed: onSecondaryButtonPressed ?? () {},
            ),
          ),
      ],
    );
  }
}
