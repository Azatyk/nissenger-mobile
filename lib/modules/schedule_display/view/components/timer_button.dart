import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 100.h,
      width: 160.w,
      child: CupertinoButton(
        padding: EdgeInsets.only(left: 12.w, bottom: 16.h,),
        alignment: Alignment.bottomLeft,
        borderRadius: BorderRadius.circular(15.r),
        color: theme.colorScheme.primary,
        onPressed: () {},
        child: Text(
              "Режим\nтаймера",
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.surface,
              ),
            ),
      ),
    );
  }
}
