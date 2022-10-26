import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Nissenger",
          style: theme.textTheme.displaySmall?.copyWith(
            fontSize: 24.sp,
            color: theme.colorScheme.primary,
          ),
        ),
        CupertinoButton(
          color: theme.colorScheme.onSurface,
          padding: EdgeInsets.all(7.r),
          borderRadius: BorderRadius.circular(30.r),
          child: FaIcon(
            FontAwesomeIcons.user,
            size: 14.sp,
            color: theme.colorScheme.primary,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
