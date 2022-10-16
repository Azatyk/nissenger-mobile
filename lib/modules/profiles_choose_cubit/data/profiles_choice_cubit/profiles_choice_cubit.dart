import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/pages/profile_groups_choice_page.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choice_cubit/profiles_choice_state.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/types/profiles_choose_states.dart';

class ProfilesChoiceCubit extends Cubit<ProfilesChoiceState> {
  ProfilesChoiceCubit()
      : super(
          const ProfilesChoiceState(
            profilesState: ProfilesStates.pure,
            mainProfiles: "",
            thirdProfile: "",
          ),
        );

  void navigateToNextPage({
    required String mainProfiles,
    required String thirdProfile,
    required BuildContext context,
  }) async {
    emit(
      ProfilesChoiceState(
          profilesState: ProfilesStates.loading,
          mainProfiles: mainProfiles,
          thirdProfile: thirdProfile),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      var box = Hive.box(UserSettingsBox.boxName);

      String profile1 = "";
      String profile2 = "";

      if (mainProfiles == "Физ | Инф") {
        profile1 = "Физика";
        profile2 = "Информатика";
      } else if (mainProfiles == "Хим | Био") {
        profile1 = "Химия";
        profile2 = "Биология";
      } else if (mainProfiles == "Физ | Био") {
        profile1 = "Физика";
        profile2 = "Биология";
      } else if (mainProfiles == "Физ | Хим") {
        profile1 = "Физика";
        profile2 = "Химия";
      } else if (mainProfiles == "Инф | Хим") {
        profile1 = "Информатика";
        profile2 = "Химия";
      } else if (mainProfiles == "Инф | Био") {
        profile1 = "Информатика";
        profile2 = "Биология";
      }

      box.put(UserSettingsBox.mainProfileOne, profile1);
      box.put(UserSettingsBox.mainProfileTwo, profile2);
      box.put(UserSettingsBox.thirdProfile, thirdProfile);

      print(box.get(UserSettingsBox.mainProfileOne));

      emit(
        ProfilesChoiceState(
            profilesState: ProfilesStates.readyToPush,
            mainProfiles: mainProfiles,
            thirdProfile: thirdProfile),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProfileGroupsChoicePage(),
        ),
      );
    } catch (err) {
      //error handling
    }
  }
}
