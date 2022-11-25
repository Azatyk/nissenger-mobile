import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/foreign_language.model.dart';
import 'package:nissenger_mobile/data/repositories/user_settings.repository.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_state.dart';

class ForeignLanguagesRequestCubit extends Cubit<ForeignLanguagesRequestState> {
  UserSettingsRepository repository;

  ForeignLanguagesRequestCubit({required this.repository})
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
      List<ForeignLanguage> foreignLanguages =
          await repository.getForeignLanguages();

      emit(
        ForeignLanguagesRequestData(
          languages: foreignLanguages,
        ),
      );
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const ForeignLanguagesInternetConnectionError());
      } else {
        emit(const ForeignLanguagesUnknownError());
      }
    }
  }
}
