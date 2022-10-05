import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CupertinoButton(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 18.h,
      ),
      color: Colors.transparent,
      child: Text(
        "Пропустить",
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
      onPressed: () {
        // todo: navigate to next page
      },
    );
  }
}
