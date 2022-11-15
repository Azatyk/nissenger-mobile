import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsButton extends StatelessWidget {
  const EventsButton({super.key});

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
          color: const Color(0xFF10AC84),
          onPressed: () {},
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "События\n(скоро)",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.surface,
                    height: 1.1,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.8, -1.2),
                child: Image.asset(
                  "assets/icons/calendar-icon.png",
                  width: 46.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
