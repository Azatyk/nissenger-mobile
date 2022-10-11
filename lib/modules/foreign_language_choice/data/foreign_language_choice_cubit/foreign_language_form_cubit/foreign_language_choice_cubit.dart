import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_form_cubit/foreign_language_choice_state.dart';

class ForeignLanguageFormCubit extends Cubit<ForeignLanguageFormState> {
  ForeignLanguageFormCubit()
      : super(
          const ForeignLanguageFormState(
            foreignLanguage: 0,
          ),
        );

  void changeForeignLanguage({required int foreignlanguage}) {
    emit(
      state.copyWith(foreignLanguage: foreignlanguage),
    );
  }
}
