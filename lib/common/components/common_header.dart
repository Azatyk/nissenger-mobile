import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_back_button.dart';

class CommonHeader extends StatelessWidget {
  final VoidCallback? onBackButtonPressed;
  final String title;

  const CommonHeader({
    Key? key,
    this.onBackButtonPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonBackButton(
          onPressed: onBackButtonPressed,
        ),
        SizedBox(height: 22.h),
        Text(
          title,
          style: theme.textTheme.headlineMedium,
        )
      ],
    );
  }
}
