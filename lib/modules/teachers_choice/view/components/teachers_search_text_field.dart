import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeachersSearchTextField extends StatelessWidget {
  const TeachersSearchTextField({
    super.key,
    required this.fieldValue,
  });

  final ValueChanged<String> fieldValue;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CupertinoSearchTextField(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      itemSize: 16,
      prefixInsets: EdgeInsets.only(left: 10.w),
      placeholder: "Поиск...",
      placeholderStyle: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSecondary,
        fontSize: 12.sp,
      ),
      onChanged: (String value) {
        fieldValue(value);
      },
      onSubmitted: (String value) {
        fieldValue(value);
      },
    );
  }
}
