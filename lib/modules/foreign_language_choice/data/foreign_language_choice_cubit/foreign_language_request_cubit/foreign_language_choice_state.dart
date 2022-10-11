import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/types/foreign_language_status.dart';

class ForeignLanguageRequestState extends Equatable {
  final ForeignLanguageState foreignLanguageState;

  const ForeignLanguageRequestState({
    required this.foreignLanguageState,
  });

  @override
  List<Object?> get props => [
        foreignLanguageState,
      ];
}