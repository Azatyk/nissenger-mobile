import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_state.dart';

class ProfileDataCubit extends Cubit<ProfileDataState> {
  ProfileDataCubit() : super(const ProfileDataPure());

  void getProfileData() {
    var box = Hive.box(UserSettingsBox.boxName);
    String userType = box.get(UserSettingsBox.userType);

    if (userType == UserTypes.student) {
      int gradeNumber = box.get(UserSettingsBox.gradeNumber);
      String gradeLetter = box.get(UserSettingsBox.gradeLetter);
      int gradeGroup = box.get(UserSettingsBox.gradeGroup);
      String firstProfile = box.get(UserSettingsBox.firstMainProfile);
      String secondProfile = box.get(UserSettingsBox.secondMainProfile);
      String thirdProfile = box.get(UserSettingsBox.thirdProfile);

      emit(
        ProfileData(
          gradeNumber: gradeNumber,
          gradeLetter: gradeLetter,
          gradeGroup: gradeGroup,
          firstProfile: firstProfile,
          secondProfile: secondProfile,
          thirdProfile: thirdProfile,
        ),
      );
    } else if (userType == UserTypes.teacher) {
      String teacherName = box.get(UserSettingsBox.teacherName);

      emit(
        ProfileData(
          teacherName: teacherName,
        ),
      );
    }
  }
}
