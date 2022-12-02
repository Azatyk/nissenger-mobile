import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/before_start_warning/view/pages/before_start_warning_page.dart';

class SkipButton extends StatelessWidget {
  final String userType;

  const SkipButton({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CupertinoButton(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 18.h,
      ),
      color: Colors.transparent,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BeforeStartWarningPage(userType: userType),
          ),
        );
      },
      child: Text(
        "Пропустить",
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
