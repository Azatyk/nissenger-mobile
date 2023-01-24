import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_choice_button.dart';
import 'package:nissenger_mobile/data/models/profile_groups.model.dart';

class ProfileGroupsList extends StatelessWidget {
  final ProfileGroups profileGroups;
  final Function({required String clickedGroup}) onGroupClicked;
  final String activeGroup;

  const ProfileGroupsList({
    Key? key,
    required this.profileGroups,
    required this.onGroupClicked,
    required this.activeGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          profileGroups.profileLesson,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.r,
          runSpacing: 12.r,
          children: profileGroups.groups
              .map(
                (group) => CommonChoiceButton(
                  text: group,
                  onClicked: () {
                    if (group != activeGroup) {
                      onGroupClicked(
                        clickedGroup: group,
                      );
                    } else {
                      onGroupClicked(
                        clickedGroup: "",
                      );
                    }
                  },
                  active: group == activeGroup,
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
