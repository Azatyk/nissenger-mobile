import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

class BeforeStartText extends StatelessWidget {
  const BeforeStartText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKeys.beforeStart.translate(context),
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.surface,
          ),
        ),
        SizedBox(height: 22.h),
        BeforeStartDescription(text: LangKeys.beforeStart1.translate(context)),
        SizedBox(height: 30.h),
        BeforeStartDescription(text: LangKeys.beforeStart2.translate(context)),
        SizedBox(height: 20.h),
        BeforeStartDescription(text: LangKeys.beforeStart3.translate(context)),
      ],
    );
  }
}

class BeforeStartDescription extends StatelessWidget {
  final String text;

  const BeforeStartDescription({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.surface,
        fontWeight: FontWeight.w400,
        height: 1.3,
      ),
    );
  }
}
