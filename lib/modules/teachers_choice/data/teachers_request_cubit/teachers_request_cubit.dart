import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/data/models/teacher.model.dart';
import 'package:nissenger_mobile/data/repositories/user_settings.repository.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_request_cubit/teachers_request_state.dart';

import '../../../../config/hive_boxes.dart';
import '../../../../config/preset_hive_class.dart';

class TeachersRequestCubit extends Cubit<TeachersRequestState> {
  UserSettingsRepository repository;

  TeachersRequestCubit({required this.repository})
      : super(const TeachersRequestLoading()) {
    loadTeachers();
  }

  void loadTeachers() async {
    emit(const TeachersRequestLoading());

    try {
      List<Teacher> teachers = await repository.getTeachers();
      emit(
        TeachersRequestData(
          teachers: teachers,
        ),
      );
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const TeachersInternetConnectionError());
      } else {
        emit(const TeachersUnknownError());
      }
    }
  }

  void clearBoxData() {
    var userSettingsBox = Hive.box(UserSettingsBox.boxName);
    var activePresetBox = Hive.box<Preset?>(ActivePresetBox.boxName);

    userSettingsBox.delete(UserSettingsBox.foreignLanguages);
    userSettingsBox.delete(UserSettingsBox.firstMainProfile);
    userSettingsBox.delete(UserSettingsBox.secondMainProfile);
    userSettingsBox.delete(UserSettingsBox.thirdProfile);
    userSettingsBox.delete(UserSettingsBox.firstProfileGroup);
    userSettingsBox.delete(UserSettingsBox.secondProfileGroup);
    userSettingsBox.delete(UserSettingsBox.thirdProfileGroup);
    userSettingsBox.delete(UserSettingsBox.teacherName);

    userSettingsBox.put(UserSettingsBox.userType, UserTypes.teacher);

    activePresetBox.deleteAll(activePresetBox.keys);
  }
}
