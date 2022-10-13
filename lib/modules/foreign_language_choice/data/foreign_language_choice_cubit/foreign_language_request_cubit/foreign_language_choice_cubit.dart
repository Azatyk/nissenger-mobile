import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_state.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/types/foreign_language_status.dart';

class ForeignLanguageChoiceCubit extends Cubit<ForeignLanguageChoiceState> {
  ForeignLanguageChoiceCubit()
      : super(
          const ForeignLanguageChoiceState(
              foreignLanguageState: ForeignLanguageState.pure,
              foreignLanguage: ""),
        );
        
  void navigateToNextPage({
    required String foreignLanguage,
  }) async {
    emit(
      ForeignLanguageChoiceState(
          foreignLanguageState: ForeignLanguageState.loading,
          foreignLanguage: foreignLanguage),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      var box = Hive.box(UserSettingsBox.boxName);
      box.put(UserSettingsBox.foreignLanguage, foreignLanguage);
      print(foreignLanguage);

      emit(
        ForeignLanguageChoiceState(
            foreignLanguageState: ForeignLanguageState.readyToPush,
            foreignLanguage: foreignLanguage,),
      );
    } catch (err) {
      //error handling
    }
  }
}
