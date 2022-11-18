import 'package:equatable/equatable.dart';

abstract class ForeignLanguageChoiceState extends Equatable {
  const ForeignLanguageChoiceState();

  @override
  List<Object?> get props => [];
}

class ForeignLanguageChoicePure extends ForeignLanguageChoiceState {
  const ForeignLanguageChoicePure();
}

class ForeignLanguageChoiceReadyToPush extends ForeignLanguageChoiceState {
  final int gradeNumber;

  const ForeignLanguageChoiceReadyToPush({required this.gradeNumber});

  @override
  List<Object?> get props => [gradeNumber];
}
