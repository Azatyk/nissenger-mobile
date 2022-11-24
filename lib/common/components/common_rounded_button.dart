import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool reverseColor;

  const CommonRoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.reverseColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CupertinoButton(
      color: reverseColor
          ? theme.colorScheme.background
          : theme.colorScheme.primary,
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 14.h,
      ),
      borderRadius: BorderRadius.circular(30.r),
      onPressed: onPressed,
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          color: reverseColor
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
