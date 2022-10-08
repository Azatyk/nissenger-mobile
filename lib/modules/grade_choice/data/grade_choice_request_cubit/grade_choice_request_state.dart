import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/types/grade_choice_status.dart';

class GradeChoiceRequestState extends Equatable {
  final GradeChoiceStatus status;

  const GradeChoiceRequestState({required this.status});

  @override
  List<Object?> get props => [status];
}
