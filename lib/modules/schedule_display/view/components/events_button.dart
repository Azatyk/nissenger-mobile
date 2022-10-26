import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsButton extends StatelessWidget {
  const EventsButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 100.h,
      width: 160.w,
      child: CupertinoButton(
        padding: EdgeInsets.only(
          left: 12.w,
          bottom: 16.h,
        ),
        alignment: Alignment.bottomLeft,
        borderRadius: BorderRadius.circular(15.r),
        color: const Color.fromRGBO(16, 172, 132, 0.2),
        onPressed: () {},
        child: Text(
          "События\n(скоро)",
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
