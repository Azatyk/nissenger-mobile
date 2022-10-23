import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/plain_data/profile_names.dart';

class SecondGroupToggleButton extends StatefulWidget {
  final Function({required String secondGroupValue}) onChanged;

  const SecondGroupToggleButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SecondGroupToggleButton> createState() =>
      _SecondGroupToggleButtonState();
}

class _SecondGroupToggleButtonState extends State<SecondGroupToggleButton> {
  String activeSecondGroup = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: List<Widget>.generate(
            10,
            (index) {
              int number = index + 1;
              String groupLetter = secondProfile[0] + number.toString();
              return CupertinoButton(
                padding: EdgeInsets.only(right: 14.w, bottom: 14.h),
                onPressed: (() {
                  setState(() {
                    activeSecondGroup = groupLetter;
                    widget.onChanged(secondGroupValue: activeSecondGroup);
                  });
                }),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: activeSecondGroup == groupLetter
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.background,
                  ),
                  child: Text(
                    groupLetter,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14.47,
                      color: activeSecondGroup == groupLetter
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
