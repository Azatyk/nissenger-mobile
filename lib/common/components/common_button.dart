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
        disabledColor: disabled
            ? theme.colorScheme.onPrimary
            : loading
                ? theme.colorScheme.primary
                : theme.colorScheme.primary,
        color: reverse
            ? theme.colorScheme.surface
            : disabled
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(10.r),
        onPressed: disabled || loading ? null : onPressed,
        child: loading
            ? Center(
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.r,
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
                    reverse: reverse,
                  ),
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  final String text;
  final bool reverse;

  const ButtonText({
    Key? key,
    required this.text,
    required this.reverse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: !reverse ? theme.colorScheme.surface : theme.colorScheme.primary,
      ),
    );
  }
}
