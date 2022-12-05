import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_state.dart';

class ProfileGroupsChoiceCubit extends Cubit<ProfileGroupsChoiceState> {
  ProfileGroupsChoiceCubit() : super(const ProfileGroupsChoicePure());

  void saveProfileGroups({
    required String firstProfileGroup,
    required String secondProfileGroup,
    required String thirdProfileGroup,
  }) {
    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.firstProfileGroup, firstProfileGroup);
    box.put(UserSettingsBox.secondProfileGroup, secondProfileGroup);
    if (thirdProfileGroup != "") {
      box.put(UserSettingsBox.thirdProfileGroup, thirdProfileGroup);
    }

    emit(const ProfileGroupsChoiceReadyToPush());
  }
}
