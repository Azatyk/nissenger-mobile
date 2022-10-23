import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/plain_data/profile_names.dart';

class MainProfilesToggleButton extends StatefulWidget {
  final Function({required String mainProfilesValue}) onChanged;

  const MainProfilesToggleButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<MainProfilesToggleButton> createState() => _MainProfilesToggleButtonState();
}

class _MainProfilesToggleButtonState extends State<MainProfilesToggleButton> {
  String activeMainProfiles = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            ...profileNames.map(
              (profiles) {
                return CupertinoButton(
                  padding: EdgeInsets.only(right: 14.w, bottom: 14.h),
                  onPressed: (() {
                    setState(() {
                      activeMainProfiles = profiles;
                      widget.onChanged(mainProfilesValue: activeMainProfiles);
                    });
                  }),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: activeMainProfiles == profiles
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.background,
                    ),
                    child: Text(
                      profiles,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 14.47,
                        color: activeMainProfiles == profiles
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
