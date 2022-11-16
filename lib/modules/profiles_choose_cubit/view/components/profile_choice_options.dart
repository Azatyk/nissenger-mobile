import "package:flutter/material.dart";
import 'package:nissenger_mobile/common/components/common_choice_button.dart';

class ProfileChoiceOptions extends StatelessWidget {
  final List<String> profileOptions;
  final Function({required String clickedProfile}) profileClicked;
  final String activeProfile;

  const ProfileChoiceOptions({
    Key? key,
    required this.profileOptions,
    required this.profileClicked,
    required this.activeProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: profileOptions
          .map(
            (profile) => CommonChoiceButton(
              text: profile,
              onClicked: () {
                if (activeProfile != profile) {
                  profileClicked(clickedProfile: profile);
                } else {
                  profileClicked(clickedProfile: "");
                }
              },
              active: activeProfile == profile,
            ),
          )
          .toList(),
    );
  }
}
