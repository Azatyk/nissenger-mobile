import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

class GreetingTitle extends StatelessWidget {
  const GreetingTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              LangKeys.nissengerGreet.translate(context),
              style: theme.textTheme.displaySmall,
            ),
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5.r),
          child: SizedBox(
            width: 30.r,
            child: Image.asset(
              "assets/images/image-logo.png",
            ),
          ),
        ),
      ],
    );
  }
}
