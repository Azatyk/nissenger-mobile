import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/types/search_states.dart';

class TeachersSearchState extends Equatable {
  final SearchStatus searchStatus;
  final String teacherName;

  const TeachersSearchState({
    required this.searchStatus,
    required this.teacherName,
  });

  @override
  List<Object?> get props => [
        searchStatus,
        teacherName,
      ];
}
