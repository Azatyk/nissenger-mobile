import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';

class GradeChoiceRequestCubit extends Cubit<GradeChoiceRequestState> {
  GradeChoiceRequestCubit()
      : super(
          const GradeChoiceRequestPure(),
        );

  void checkGradeExisting({
    required int gradeNumber,
    required String gradeLetter,
  }) async {
    emit(
      const GradeChoiceGradeExistingLoading(),
    );

    try {
      // todo: implement grade existing checking request
      await Future.delayed(const Duration(seconds: 1));

      emit(
        const GradeChoiceGradeExistingChecked(),
      );
    } catch (err) {
      // todo: handle error
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
