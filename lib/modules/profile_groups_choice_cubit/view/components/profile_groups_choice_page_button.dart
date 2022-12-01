import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_state.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_request_cubit/profile_groups_request_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_request_cubit/profile_groups_request_state.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';

class ProfileGroupsChoicePageButton extends StatelessWidget {
  final String firstGroup;
  final String secondGroup;
  final String thirdGroup;

  const ProfileGroupsChoicePageButton({
    Key? key,
    required this.firstGroup,
    required this.secondGroup,
    required this.thirdGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileGroupsChoiceCubit, ProfileGroupsChoiceState>(
      listenWhen: (prevState, newState) =>
          newState is ProfileGroupsChoiceReadyToPush,
      listener: (context, state) {
        Navigator.of(context).pushAndRemoveUntil<void>(
          MaterialPageRoute<void>(
            builder: (context) => const SchedulePage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      builder: (context, state) =>
          BlocBuilder<ProfileGroupsRequestCubit, ProfileGroupsRequestState>(
        builder: (context, state) => CommonButton(
          disabled: firstGroup == "" ||
              secondGroup == "" ||
              ((state is ProfileGroupsRequestData
                      ? !state.thirdProfileExtendedMath
                      : false) &&
                  thirdGroup == ""),
          text: "Далее",
          icon: FontAwesomeIcons.arrowRight,
          onPressed: () {
            BlocProvider.of<ProfileGroupsChoiceCubit>(context)
                .saveProfileGroups(
              firstProfileGroup: firstGroup,
              secondProfileGroup: secondGroup,
              thirdProfileGroup: thirdGroup,
            );
          },
        ),
      ),
    );
  }
}
