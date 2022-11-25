import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/foreign_language.model.dart';

abstract class ForeignLanguagesRequestState extends Equatable {
  const ForeignLanguagesRequestState();

  @override
  List<Object?> get props => [];
}

class ForeignLanguagesRequestLoading extends ForeignLanguagesRequestState {
  const ForeignLanguagesRequestLoading();
}

class ForeignLanguagesInternetConnectionError
    extends ForeignLanguagesRequestState {
  const ForeignLanguagesInternetConnectionError();
}

class ForeignLanguagesUnknownError extends ForeignLanguagesRequestState {
  const ForeignLanguagesUnknownError();
}

class ForeignLanguagesRequestData extends ForeignLanguagesRequestState {
  final List<ForeignLanguage> languages;

  const ForeignLanguagesRequestData({required this.languages});

  @override
  List<Object?> get props => [languages];
}
