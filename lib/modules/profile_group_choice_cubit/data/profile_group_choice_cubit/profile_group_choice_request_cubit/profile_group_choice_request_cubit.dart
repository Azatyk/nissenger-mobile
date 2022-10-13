import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/profile_group_choice_cubit/data/profile_group_choice_cubit/profile_group_choice_request_cubit/profile_group_choice_request_state.dart';
import 'package:nissenger_mobile/modules/profile_group_choice_cubit/data/types/profile_group_choice_state.dart';

class ProfileGroupChoiceRequestCubit extends Cubit<ProfileGroupChoiceRequestState> {
  ProfileGroupChoiceRequestCubit()
      : super(
          const ProfileGroupChoiceRequestState(profileGroupChoiceState: ProfileGroupChoiceState.pure),
        );

  void navigateToNextPage({
    required String firstGroup,
    required String secondGroup,
    required String thirdGroup,
  }) async {
    emit(
      const ProfileGroupChoiceRequestState(profileGroupChoiceState: ProfileGroupChoiceState.loading),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      var box = Hive.box(UserSettingsBox.boxName);
      box.put(UserSettingsBox.profileGroupOne, firstGroup );
      box.put(UserSettingsBox.profileGroupTwo, secondGroup);
      box.put(UserSettingsBox.profileGroupThree, thirdGroup);
      print(firstGroup);

      emit(
        const ProfileGroupChoiceRequestState(profileGroupChoiceState: ProfileGroupChoiceState.readyToPush),
      );
    } catch (err) {
      //error handling
    }
  }
}
