import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_state.dart';

class ForeignLanguageChoiceCubit extends Cubit<ForeignLanguageChoiceState> {
  ForeignLanguageChoiceCubit()
      : super(
          const ForeignLanguageChoicePure(),
        );

  void saveForeignLanguage({required List<String> foreignLanguages}) {
    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.foreignLanguages, foreignLanguages);

    int gradeNumber = box.get(UserSettingsBox.gradeNumber);

    emit(
      ForeignLanguageChoiceReadyToPush(gradeNumber: gradeNumber),
    );
    
    emit(const ForeignLanguageChoicePure());
  }
}
