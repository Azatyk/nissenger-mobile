import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/pages/profile_groups_choice_page.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choice_cubit/profiles_choice_cubit.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choice_cubit/profiles_choice_state.dart';

class ProfilesChoicePageButton extends StatelessWidget {
  final String mainProfiles;
  final String thirdProfile;

  const ProfilesChoicePageButton({
    Key? key,
    required this.mainProfiles,
    required this.thirdProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilesChoiceCubit, ProfilesChoiceState>(
      listenWhen: (prevState, newState) =>
          newState is ProfilesChoiceReadyToPush,
      listener: (context, state) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfileGroupsChoicePage(),
          ),
        );
      },
      builder: (context, state) => CommonButton(
        disabled: mainProfiles == "" || thirdProfile == "",
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<ProfilesChoiceCubit>(context).saveProfileChoice(
            mainProfiles: mainProfiles,
            thirdProfile: thirdProfile,
          );
        },
      ),
    );
  }
}
