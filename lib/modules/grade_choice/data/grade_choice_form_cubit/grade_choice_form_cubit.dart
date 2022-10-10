import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_state.dart';

class GradeChoiceFormCubit extends Cubit<GradeChoiceFormState> {
  GradeChoiceFormCubit()
      : super(const GradeChoiceFormState(
          gradeNumber: 8,
          gradeLetter: "K",
          group: 1,
          hasForeignLanguage: false,
        ));

  void changeGradeNumber({required int gradeNumber}) {
    emit(
      state.copyWith(gradeNumber: gradeNumber),
    );
  }

  void changeGradeLetter({required String gradeLetter}) {
    emit(
      state.copyWith(gradeLetter: gradeLetter),
    );
  }

  void changeGradeGroup({required int group}) {
    emit(
      state.copyWith(group: group),
    );
  }

  void changePresenceOfForeignLanguage({required bool? hasForeignLanguage}) {
    emit(
      state.copyWith(hasForeignLanguage: hasForeignLanguage),
    );
  }
}
