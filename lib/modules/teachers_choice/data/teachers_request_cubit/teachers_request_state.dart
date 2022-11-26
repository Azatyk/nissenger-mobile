import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/teacher.model.dart';

abstract class TeachersRequestState extends Equatable {
  const TeachersRequestState();

  @override
  List<Object?> get props => [];
}

class TeachersRequestLoading extends TeachersRequestState {
  const TeachersRequestLoading();
}

class TeachersInternetConnectionError extends TeachersRequestState {
  const TeachersInternetConnectionError();
}

class TeachersUnknownError extends TeachersRequestState {
  const TeachersUnknownError();
}

class TeachersRequestData extends TeachersRequestState {
  final List<Teacher> teachers;

  const TeachersRequestData({required this.teachers});

  @override
  List<Object?> get props => [teachers];
}
