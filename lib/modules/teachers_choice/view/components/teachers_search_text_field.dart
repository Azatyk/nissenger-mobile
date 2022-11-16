import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeachersSearchTextField extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;

  const TeachersSearchTextField({
    super.key,
    required this.onQueryChanged,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CupertinoSearchTextField(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      itemSize: 15.sp,
      prefixInsets: EdgeInsets.only(left: 10.w),
      placeholder: "Поиск...",
      placeholderStyle: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSecondary,
        fontSize: 12.sp,
      ),
      style: TextStyle(
        fontSize: 13.sp,
        letterSpacing: 1.1,
      ),
      suffixInsets: EdgeInsets.only(right: 12.w),
      onChanged: (String value) {
        onQueryChanged(value);
      },
    );
  }
}
