import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_choice_button.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/data/plain_data/ten_grade_profiles_options.dart';

class TenGradeProfilesList extends StatefulWidget {
  final Function({required String profileValue}) onActiveProfileChanged;

  const TenGradeProfilesList({
    Key? key,
    required this.onActiveProfileChanged,
  }) : super(key: key);

  @override
  State<TenGradeProfilesList> createState() => _TenGradeProfilesListState();
}

class _TenGradeProfilesListState extends State<TenGradeProfilesList> {
  String activeProfile = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          spacing: 12.r,
          runSpacing: 12.r,
          children: [
            ...TenGradeProfilesOptions.profiles.map(
              (profile) {
                return CommonChoiceButton(
                  text: profile,
                  onClicked: () {
                    if (activeProfile != profile) {
                      setState(() {
                        activeProfile = profile;
                      });

                      widget.onActiveProfileChanged(profileValue: profile);
                    } else {
                      setState(() {
                        activeProfile = "";
                      });

                      widget.onActiveProfileChanged(profileValue: "");
                    }
                  },
                  active: activeProfile == profile,
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
