import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/foreign_language.dart';

class ForeignLanguagesRequestState extends Equatable {
  const ForeignLanguagesRequestState();

  @override
  List<Object?> get props => [];
}

class ForeignLanguagesRequestLoading extends ForeignLanguagesRequestState {
  const ForeignLanguagesRequestLoading();
}

class ForeignLanguagesRequestError extends ForeignLanguagesRequestState {
  const ForeignLanguagesRequestError();
}

class ForeignLanguagesRequestData extends ForeignLanguagesRequestState {
  final List<ForeignLanguage> languages;

  const ForeignLanguagesRequestData({required this.languages});

  @override
  List<Object?> get props => [languages];
}
