import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonPlaceholder extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const CommonPlaceholder({
    required this.text,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.only(bottom: 100.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.boxOpen,
              color: theme.colorScheme.primary,
              size: 36.sp,
            ),
            SizedBox(height: 14.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
