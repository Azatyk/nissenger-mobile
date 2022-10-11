import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/types/foreign_language_status.dart';

class ForeignLanguageFormState extends Equatable {
  final int foreignLanguage;

  const ForeignLanguageFormState({
    required this.foreignLanguage,
  });

  @override
  List<Object?> get props => [
        foreignLanguage,
      ];

  ForeignLanguageFormState copyWith({
    int? foreignLanguage
  }) {
    return ForeignLanguageFormState(
      foreignLanguage: foreignLanguage ?? this.foreignLanguage,
    );
  }
}