import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_state.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/types/foreign_language_status.dart';

class ForeignLanguageRequestCubit extends Cubit<ForeignLanguageRequestState> {
  ForeignLanguageRequestCubit()
      : super(
          const ForeignLanguageRequestState(foreignLanguageState: ForeignLanguageState.pure),
        );

  void navigateToNextPage({
    required String foreignLanguage,
  }) async {
    emit(
      const ForeignLanguageRequestState(foreignLanguageState: ForeignLanguageState.loading),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      var box = Hive.box(UserSettingsBox.boxName);
      print(foreignLanguage);
      box.put(UserSettingsBox.foreignLanguage, foreignLanguage);

      emit(
        const ForeignLanguageRequestState(foreignLanguageState: ForeignLanguageState.readyToPush),
      );
    } catch (err) {
      //error handling
    }
  }
}
