import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/plain_data/profile_names.dart';

class FirstGroupToggleButton extends StatefulWidget {
  final Function({required String firstGroupValue}) onChanged;

  const FirstGroupToggleButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FirstGroupToggleButton> createState() => _FirstGroupToggleButtonState();
}

class _FirstGroupToggleButtonState extends State<FirstGroupToggleButton> {
  String activeFirstGroup = "";

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
              String groupLetter = firstProfile[0] + index.toString();
              return CupertinoButton(
                padding: EdgeInsets.only(right: 18.w, bottom: 15.h),
                onPressed: (() {
                  setState(() {
                    activeFirstGroup = groupLetter;
                    widget.onChanged(firstGroupValue: activeFirstGroup);
                  });
                }),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: activeFirstGroup == groupLetter
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.background,
                  ),
                  child: Text(
                    groupLetter,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14.47,
                      color: activeFirstGroup == groupLetter
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
