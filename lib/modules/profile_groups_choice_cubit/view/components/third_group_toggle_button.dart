import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/plain_data/profile_names.dart';

class ThirdGroupToggleButton extends StatefulWidget {
  final Function({required String thirdGroupValue}) onChanged;

  const ThirdGroupToggleButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ThirdGroupToggleButton> createState() => _ThirdGroupToggleButtonState();
}

class _ThirdGroupToggleButtonState extends State<ThirdGroupToggleButton> {
  String activeThirdGroup = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: List<Widget>.generate(
            3,
            (index) {
              int number = index + 1;
              String groupLetter = thirdProfile[0] + number.toString();
              return CupertinoButton(
                padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
                onPressed: (() {
                  setState(() {
                    activeThirdGroup = groupLetter;
                    widget.onChanged(thirdGroupValue: activeThirdGroup);
                  });
                }),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: activeThirdGroup == groupLetter
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.background,
                  ),
                  child: Text(
                    groupLetter,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14.47,
                      color: activeThirdGroup == groupLetter
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
