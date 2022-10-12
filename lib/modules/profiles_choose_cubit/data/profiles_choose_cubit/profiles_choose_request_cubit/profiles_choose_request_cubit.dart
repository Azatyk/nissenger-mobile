import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choose_cubit/profiles_choose_request_cubit/profiles_choose_request_state.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/types/profiles_choose_states.dart';

class ProfilesChooseRequestCubit extends Cubit<ProfilesChooseRequestState> {
  ProfilesChooseRequestCubit()
      : super(
          const ProfilesChooseRequestState(profilesChooseState: ProfilesChooseStates.pure),
        );

  void navigateToNextPage({
    required String mainProfiles,
    required String thirdProfile,
  }) async {
    emit(
      const ProfilesChooseRequestState(profilesChooseState: ProfilesChooseStates.loading),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      var box = Hive.box(UserSettingsBox.boxName);
      box.put(UserSettingsBox.mainProfiles, mainProfiles);
      box.put(UserSettingsBox.thirdProfile, thirdProfile);
      print(mainProfiles);
      print(thirdProfile);

      emit(
        const ProfilesChooseRequestState(profilesChooseState: ProfilesChooseStates.readyToPush),
      );
    } catch (err) {
      //error handling
    }
  }
}
