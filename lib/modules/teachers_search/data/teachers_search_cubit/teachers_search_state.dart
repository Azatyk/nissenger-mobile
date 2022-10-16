import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/types/search_states.dart';

class TeachersSearchState extends Equatable {
  final SearchStatus searchStatus;
  final String teacherFirstName;
  final String teacherSecondName;
  final String teacherThirdName;

  const TeachersSearchState({
    required this.searchStatus,
    required this.teacherFirstName,
    required this.teacherSecondName,
    required this.teacherThirdName,
  });

  @override
  List<Object?> get props => [
        searchStatus,
        teacherFirstName,
        teacherSecondName,
        teacherThirdName,
      ];
}
