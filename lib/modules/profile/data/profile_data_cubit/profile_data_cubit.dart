import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/config.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/helpers/localization_service.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_state.dart';

class ProfileDataCubit extends Cubit<ProfileDataState> {
  ProfileDataCubit() : super(const ProfileDataPure());

  var box = Hive.box(UserSettingsBox.boxName);
  var presetsBox = Hive.box<Preset>(PresetsListBox.boxName);
  var activePresetBox = Hive.box<Preset?>(ActivePresetBox.boxName);
  final localizationController = Get.find<LocalizationController>();

  void getProfileData() {
    Preset? activePreset = activePresetBox.getAt(0);

    String userType = activePreset!.userType;

    if (userType == UserTypes.student) {
      int gradeNumber = activePreset.gradeNumber;
      String gradeLetter = activePreset.gradeLetter;
      int gradeGroup = activePreset.gradeGroup;
      String? firstProfile = activePreset.firstMainProfile;
      String? secondProfile = activePreset.secondMainProfile;
      String? thirdProfile = activePreset.thirdProfile;
      String? firstProfileGroup = activePreset.firstProfileGroup;
      List<String>? foreignLanugages = activePreset.foreignLanguages;

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
      String teacherName = activePreset.teacherName;

      emit(
        ProfileData(
          userType: userType,
          teacherName: teacherName,
        ),
      );
    }
  }

  void changeGradeGroup({required int newGroup}) {
    Preset? activePreset = activePresetBox.getAt(0);

    var presetsList = presetsBox.values;
    Preset? changingPreset = presetsList.firstWhere(
        (element) => element.presetName == activePreset!.presetName);

    activePreset!.gradeGroup = newGroup;

    changingPreset.gradeGroup = newGroup;
  }

  void setInitialData() {
    box.put(UserSettingsBox.city, Config.requestCity);
    box.put(UserSettingsBox.school, Config.requestSchool);
  }

  void setUserType({required String userType}) {
    box.put(UserSettingsBox.userType, userType);
  }

  void changeLanguage() {
    localizationController.toggleLanguage();
  }

  void logout() {
    box.deleteAll(box.keys);
    presetsBox.deleteAll(presetsBox.keys);
    activePresetBox.deleteAll(activePresetBox.keys);
  }
}
