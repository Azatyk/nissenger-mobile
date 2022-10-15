import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
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
      box.put(UserSettingsBox.mainProfiles, mainProfiles);
      box.put(UserSettingsBox.thirdProfile, thirdProfile);

      emit(
        ProfilesChoiceState(
            profilesState: ProfilesStates.readyToPush,
            mainProfiles: mainProfiles, 
            thirdProfile: thirdProfile),
      );
    } catch (err) {
      //error handling
    }
  }
}
