import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BeforeStartCloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BeforeStartCloseButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 42.r,
      width: 42.r,
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        color: const Color(0xFF2D3436).withOpacity(0.2),
        borderRadius: BorderRadius.circular(100.r),
        onPressed: onPressed,
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.xmark,
            color: theme.colorScheme.surface.withOpacity(0.8),
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}
