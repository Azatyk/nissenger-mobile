import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/config.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_state.dart';

class ProfileDataCubit extends Cubit<ProfileDataState> {
  ProfileDataCubit() : super(const ProfileDataPure());

  var box = Hive.box(UserSettingsBox.boxName);
  var presetsBox = Hive.box<Preset>(PresetsListBox.boxName);
  var activePresetBox = Hive.box<Preset?>(ActivePresetBox.boxName);

  void getProfileData() {
    String userType = box.get(UserSettingsBox.userType);

    if (userType == UserTypes.student) {
      int gradeNumber = box.get(UserSettingsBox.gradeNumber);
      String gradeLetter = box.get(UserSettingsBox.gradeLetter);
      int gradeGroup = box.get(UserSettingsBox.gradeGroup);
      String? firstProfile = box.get(UserSettingsBox.firstMainProfile);
      String? secondProfile = box.get(UserSettingsBox.secondMainProfile);
      String? thirdProfile = box.get(UserSettingsBox.thirdProfile);
      String? firstProfileGroup = box.get(UserSettingsBox.firstProfileGroup);
      List<String>? foreignLanugages =
          box.get(UserSettingsBox.foreignLanguages);

      emit(
        ProfileData(
          userType: userType,
          gradeNumber: gradeNumber,
          gradeLetter: gradeLetter,
          gradeGroup: gradeGroup,
          firstProfile: firstProfile,
          secondProfile: secondProfile,
          thirdProfile: thirdProfile,
          firstProfileGroup: firstProfileGroup,
          foreignLanguages: foreignLanugages,
        ),
      );
    } else if (userType == UserTypes.teacher) {
      String teacherName = box.get(UserSettingsBox.teacherName);

      emit(
        ProfileData(
          userType: userType,
          teacherName: teacherName,
        ),
      );
    }
  }

  void changeGradeGroup({required int newGroup}) {
    box.put(UserSettingsBox.gradeGroup, newGroup);
  }

  void setInitialData() {
    box.put(UserSettingsBox.city, Config.requestCity);
    box.put(UserSettingsBox.school, Config.requestSchool);
  }

  void setUserType({required String userType}) {
    box.put(UserSettingsBox.userType, userType);
  }

  void logout() {
    box.deleteAll(box.keys);
    presetsBox.deleteAll(presetsBox.keys);
    activePresetBox.deleteAll(activePresetBox.keys);
  }
}
