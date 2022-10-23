import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_state.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/types/foreign_language_status.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/pages/profiles_choose_page.dart';

class ForeignLanguageChoiceCubit extends Cubit<ForeignLanguageChoiceState> {
  ForeignLanguageChoiceCubit()
      : super(
          const ForeignLanguageChoiceState(
              foreignLanguageState: ForeignLanguageState.pure,
              foreignLanguage: ""),
        );

  void navigateToNextPage({
    required String foreignLanguage,
    required BuildContext context,
  }) async {
    emit(
      ForeignLanguageChoiceState(
          foreignLanguageState: ForeignLanguageState.loading,
          foreignLanguage: foreignLanguage),
    );

    try {
      var box = Hive.box(UserSettingsBox.boxName);
      box.put(UserSettingsBox.foreignLanguage, foreignLanguage);

      emit(
        ForeignLanguageChoiceState(
          foreignLanguageState: ForeignLanguageState.readyToPush,
          foreignLanguage: foreignLanguage,
        ),
      );
      if (state.foreignLanguageState == ForeignLanguageState.readyToPush) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfilesChoosePage(),
          ),
        );
      }
    } catch (err) {
      //error handling
    }
  }

  void navigateBack({required BuildContext context}) {
    Navigator.of(context).pop();
    emit(
      const ForeignLanguageChoiceState(
        foreignLanguageState: ForeignLanguageState.pure,
        foreignLanguage: UserSettingsBox.foreignLanguage,
      ),
    );
  }
}
