import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CommonBackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CupertinoButton(
      color: theme.colorScheme.background,
      padding: EdgeInsets.all(9.r),
      borderRadius: BorderRadius.circular(30.r),
      onPressed: onPressed,
      child: FaIcon(
        FontAwesomeIcons.arrowLeft,
        size: 15.sp,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
