import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonChoiceButton extends StatelessWidget {
  final String text;
  final Function onClicked;
  final bool active;

  const CommonChoiceButton({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 48.h,
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(10.r),
        color:
            active ? theme.colorScheme.onSurface : theme.colorScheme.background,
        onPressed: () {
          onClicked();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            text,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 14.sp,
              color:
                  active ? theme.colorScheme.primary : theme.colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
