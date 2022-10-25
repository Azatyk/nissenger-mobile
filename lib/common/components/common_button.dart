import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool reverse;
  final bool disabled;
  final bool loading;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.reverse = false,
    this.disabled = false,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        color: reverse
            ? theme.colorScheme.surface
            : disabled
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(10.r),
        onPressed: disabled ? () {} : onPressed,
        child: loading
            ? Center(
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.surface,
                  ),
                ),
              )
            : icon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonText(
                          text: text,
                          theme: theme,
                          reverse: reverse,
                        ),
                        SizedBox(width: 10.w),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: FaIcon(
                            icon,
                            size: 13.sp,
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  )
                : ButtonText(
                    text: text,
                    theme: theme,
                    reverse: reverse,
                  ),
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  final String text;
  final ThemeData theme;
  final bool reverse;

  const ButtonText({
    Key? key,
    required this.text,
    required this.theme,
    required this.reverse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        color: !reverse ? theme.colorScheme.surface : theme.colorScheme.primary,
      ),
    );
  }
}
