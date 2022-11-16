import 'package:equatable/equatable.dart';

class TeachersSearchState extends Equatable {
  final List<String> searchedTeachersList;
  final List<String> initialTeachersList;

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
