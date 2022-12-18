import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileLink extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool logout;

  const ProfileLink({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.logout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
        height: 30.h,
        child: CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      icon,
                      color: !logout
                          ? theme.colorScheme.primary
                          : theme.colorScheme.error,
                      size: 18.sp,
                    ),
                    SizedBox(width: 16.w),
                    Flexible(
                      child: Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: !logout
                              ? theme.colorScheme.secondary
                              : theme.colorScheme.error,
                        ),
                      ),
                    ),
                    SizedBox(width: 22.w),
                  ],
                ),
              ),
              FaIcon(
                FontAwesomeIcons.chevronRight,
                color: !logout
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
