import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/plain_data/profile_names.dart';

class ThirdProfileToggleButton extends StatefulWidget {
  final Function({required String thirdProfileValue}) onChanged;

  const ThirdProfileToggleButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ThirdProfileToggleButton> createState() => _ThirdProfileToggleButtonState();
}

class _ThirdProfileToggleButtonState extends State<ThirdProfileToggleButton> {
  String activeThirdProfile = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            ...thirdProfileName.map(
              (thirdProfile) {
                return CupertinoButton(
                  padding: EdgeInsets.only(right: 14.w, bottom: 14.h),
                  onPressed: (() {
                    setState(() {
                      activeThirdProfile = thirdProfile;
                      widget.onChanged(thirdProfileValue: activeThirdProfile);
                    });
                  }),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: activeThirdProfile == thirdProfile
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.background,
                    ),
                    child: Text(
                      thirdProfile,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 14.47,
                        color: activeThirdProfile == thirdProfile
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
