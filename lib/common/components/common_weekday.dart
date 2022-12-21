import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonWeekday extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onPressed;

  const CommonWeekday({
    Key? key,
    required this.text,
    required this.active,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(10.r),
        color:
            active ? theme.colorScheme.onSurface : theme.colorScheme.background,
        onPressed: onPressed,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            fontSize: 14.sp,
            color: active
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
