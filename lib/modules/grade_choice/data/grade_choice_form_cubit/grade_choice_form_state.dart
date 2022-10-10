import 'package:equatable/equatable.dart';

class GradeChoiceFormState extends Equatable {
  final int gradeNumber;
  final String gradeLetter;
  final int group;
  final bool hasForeignLanguage;

  const GradeChoiceFormState({
    required this.gradeNumber,
    required this.gradeLetter,
    required this.group,
    required this.hasForeignLanguage,
  });

  @override
  List<Object?> get props => [
        gradeNumber,
        gradeLetter,
        group,
        hasForeignLanguage,
      ];

  GradeChoiceFormState copyWith({
    int? gradeNumber,
    String? gradeLetter,
    int? group,
    bool? hasForeignLanguage,
  }) {
    return GradeChoiceFormState(
      gradeNumber: gradeNumber ?? this.gradeNumber,
      gradeLetter: gradeLetter ?? this.gradeLetter,
      group: group ?? this.group,
      hasForeignLanguage: hasForeignLanguage ?? this.hasForeignLanguage,
    );
  }
}
