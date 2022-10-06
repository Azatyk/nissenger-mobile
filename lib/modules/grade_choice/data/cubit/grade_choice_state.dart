import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/types/grade_choice_status.dart';

class GradeChoiceState extends Equatable {
  final GradeChoiceStatus status;

  const GradeChoiceState({required this.status});

  @override
  List<Object?> get props => [status];
}

// class GradeChoiceState extends Equatable {
//   final int gradeNumber;
//   final String gradeLetter;
//   final int group;
//   final bool hasForeignLanguage;

//   const GradeChoiceState({
//     required this.gradeNumber,
//     required this.gradeLetter,
//     required this.group,
//     required this.hasForeignLanguage,
//   });

//   @override
//   List<Object?> get props => [
//         gradeNumber,
//         gradeLetter,
//         group,
//         hasForeignLanguage,
//       ];

//   GradeChoiceState copyWith({
//     int? gradeNumber,
//     String? gradeLetter,
//     int? group,
//     bool? hasForeignLanguage,
//   }) {
//     return GradeChoiceState(
//       gradeNumber: gradeNumber ?? this.gradeNumber,
//       gradeLetter: gradeLetter ?? this.gradeLetter,
//       group: group ?? this.group,
//       hasForeignLanguage: hasForeignLanguage ?? this.hasForeignLanguage,
//     );
//   }
// }
