import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_state.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/plain_data/languages.dart';

class ForeignLanguagesRequestCubit extends Cubit<ForeignLanguagesRequestState> {
  ForeignLanguagesRequestCubit()
      : super(
          const ForeignLanguagesRequestLoading(),
        ) {
    getLanguages();
  }

  void getLanguages() async {
    emit(
      const ForeignLanguagesRequestLoading(),
    );

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(
        ForeignLanguagesRequestData(
          languages: MockForeignLanuages.getLanguages(),
        ),
      );
    } catch (err) {
      // todo: handle error
    }
  }
}
