import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/types/foreign_language_status.dart';

class ForeignLanguageChoiceState extends Equatable {
  final ForeignLanguageState foreignLanguageState;
  final String foreignLanguage;

  const ForeignLanguageChoiceState({
    required this.foreignLanguageState,
    required this.foreignLanguage,
  });

  @override
  List<Object?> get props => [
        foreignLanguageState,
        foreignLanguage,
      ];
}