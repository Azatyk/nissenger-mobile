import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/cubit/grade_choice_state.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/types/grade_choice_status.dart';

class GradeChoiceCubit extends Cubit<GradeChoiceState> {
  GradeChoiceCubit()
      : super(const GradeChoiceState(
          status: GradeChoiceStatus.pure,
        ));

  void navigateNextPage({
    required int gradeNumber,
    required String gradeLetter,
    required int group,
    required bool hasForeignLanguage,
  }) async {
    emit(const GradeChoiceState(status: GradeChoiceStatus.loading));

    await Future.delayed(
        const Duration(seconds: 3)); // todo: grade existing checking request

    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.gradeNumber, gradeNumber);
    box.put(UserSettingsBox.gradeLetter, gradeLetter);
    box.put(UserSettingsBox.gradeGroup, group);
    box.put(UserSettingsBox.hasStudentForeignLanguage, hasForeignLanguage);

    emit(const GradeChoiceState(status: GradeChoiceStatus.readyToPush));
  }
}
