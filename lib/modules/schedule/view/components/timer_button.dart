import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/timer/view/pages/timer_page.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth - 6,
        height: 100.h,
        child: CupertinoButton(
          padding: EdgeInsets.only(
            left: 14.w,
            bottom: 16.h,
          ),
          borderRadius: BorderRadius.circular(10.r),
          color: theme.colorScheme.primary,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const TimerPage(),
              ),
              (route) => false,
            );
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  LangKeys.timer.translate(context),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.surface,
                    height: 1.1,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(1.1, -2.2),
                child: Image.asset(
                  "assets/icons/time-icon.png",
                  width: 60.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
