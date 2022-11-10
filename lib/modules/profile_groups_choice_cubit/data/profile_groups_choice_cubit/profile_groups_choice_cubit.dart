import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_state.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/types/profile_groups_choice.dart';

class ProfileGroupsChoiceCubit extends Cubit<ProfileGroupsChoiceState> {
  ProfileGroupsChoiceCubit()
      : super(
          const ProfileGroupsChoiceState(
              groupsChoiceState: GroupsChoiceState.pure,
              firstGroup: "",
              secondGroup: "",
              thirdGroup: ""),
        );

  void navigateToNextPage({
    required String firstGroup,
    required String secondGroup,
    required String thirdGroup,
    required BuildContext context,
  }) async {
    emit(
      ProfileGroupsChoiceState(
        groupsChoiceState: GroupsChoiceState.loading,
        firstGroup: firstGroup,
        secondGroup: secondGroup,
        thirdGroup: thirdGroup,
      ),
    );

    try {
      var box = Hive.box(UserSettingsBox.boxName);
      box.put(UserSettingsBox.profileGroupOne, firstGroup);
      box.put(UserSettingsBox.profileGroupTwo, secondGroup);
      box.put(UserSettingsBox.profileGroupThree, thirdGroup);

      emit(
        ProfileGroupsChoiceState(
            groupsChoiceState: GroupsChoiceState.readyToPush,
            firstGroup: firstGroup,
            secondGroup: secondGroup,
            thirdGroup: thirdGroup),
      );
    } catch (err) {
      //error handling
    }
  }
}
