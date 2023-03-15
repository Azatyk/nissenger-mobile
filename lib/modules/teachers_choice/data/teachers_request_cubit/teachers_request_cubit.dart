import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/data/models/teacher.model.dart';
import 'package:nissenger_mobile/data/repositories/user_settings.repository.dart';
import 'package:nissenger_mobile/helpers/hive_clear.dart';
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

  void clearHiveBoxes() {
    clearBoxData(userType: UserTypes.teacher);
  }
}
