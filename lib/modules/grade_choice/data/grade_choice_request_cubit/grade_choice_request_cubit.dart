import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/view/pages/foreign_language_choice_page.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/types/grade_choice_status.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/pages/profiles_choose_page.dart';

class GradeChoiceRequestCubit extends Cubit<GradeChoiceRequestState> {
  GradeChoiceRequestCubit()
      : super(
          const GradeChoiceRequestState(status: GradeChoiceStatus.pure),
        );

  void navigateToNextPage({
    required int gradeNumber,
    required String gradeLetter,
    required int gradeGroup,
    required bool hasForeignLanguage,
    required BuildContext context,
  }) async {
    emit(
      const GradeChoiceRequestState(status: GradeChoiceStatus.loading),
    );

    try {
      // todo: implement grade existing checking request
      await Future.delayed(const Duration(seconds: 1));

      var box = Hive.box(UserSettingsBox.boxName);

      box.put(UserSettingsBox.gradeNumber, gradeNumber);
      box.put(UserSettingsBox.gradeLetter, gradeLetter);
      box.put(UserSettingsBox.gradeGroup, gradeGroup);
      box.put(UserSettingsBox.hasStudentForeignLanguage, hasForeignLanguage);

      emit(
        const GradeChoiceRequestState(status: GradeChoiceStatus.readyToPush),
      );
      if (state.status == GradeChoiceStatus.readyToPush) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => hasForeignLanguage
                  ? const ForeignLanguageChoicePage()
                  : const ProfilesChoosePage()),
        );
      }
    } catch (err) {
      // todo: handle error
    }
  }

  void navigateBack({required BuildContext context}) {
    Navigator.of(context).pop();
    emit(
      const GradeChoiceRequestState(
        status: GradeChoiceStatus.pure,
      ),
    );
  }
}
