import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';

class TimerPageBackButton extends StatelessWidget {
  const TimerPageBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 42.h,
      width: 42.w,
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        color: const Color(0xFF2D3436).withOpacity(0.2),
        borderRadius: BorderRadius.circular(100.r),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const SchedulePage(),
            ),
            (route) => false,
          );
        },
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: theme.colorScheme.surface.withOpacity(0.8),
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}
