import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/teacher.model.dart';

class TeachersSearchState extends Equatable {
  final List<Teacher> searchedTeachersList;
  final List<Teacher> initialTeachersList;

  const TeachersSearchState({
    required this.searchedTeachersList,
    required this.initialTeachersList,
  });

  @override
  List<Object?> get props => [
        searchedTeachersList,
        initialTeachersList,
      ];
}
