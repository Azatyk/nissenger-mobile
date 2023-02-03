import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/data/repositories/user_settings.repository.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';

class GradeChoiceRequestCubit extends Cubit<GradeChoiceRequestState> {
  UserSettingsRepository repository;

  GradeChoiceRequestCubit({required this.repository})
      : super(const GradeChoiceRequestPure());

  void checkGradeExisting({
    required int gradeNumber,
    required String gradeLetter,
  }) async {
    emit(
      const GradeChoiceGradeExistingLoading(),
    );

    try {
      await repository.checkGradeExisting(
        gradeNumber: gradeNumber,
        gradeLetter: gradeLetter,
      );

      emit(
        const GradeChoiceGradeExistingChecked(),
      );
    } on DioError catch (err) {
      if (err.response?.statusCode == 404) {
        emit(const GradeChoiceGradeCheckingFailed());
      } else {
        ConnectivityResult connectionResult =
            await (Connectivity().checkConnectivity());

        if (connectionResult == ConnectivityResult.none) {
          emit(const GradeChoiceGradeCheckingInternetConnectionError());
        } else {
          emit(const GradeChoiceGradeCheckingUnknownError());
        }
      }
    } catch (_) {
      emit(const GradeChoiceGradeCheckingUnknownError());
    }
  }

  void saveGradeChoiceData({
    required int gradeNumber,
    required String gradeLetter,
    required int gradeGroup,
    required bool hasForeignLanguage,
  }) {
    var box = Hive.box(UserSettingsBox.boxName);

    box.put(UserSettingsBox.gradeNumber, gradeNumber);
    box.put(UserSettingsBox.gradeLetter, gradeLetter);
    box.put(UserSettingsBox.gradeGroup, gradeGroup);

    emit(
      const GradeChoiceRequestReadyToPush(),
    );
  }
}
