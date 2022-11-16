import 'package:equatable/equatable.dart';

abstract class TeachersRequestState extends Equatable {
  const TeachersRequestState();

  @override
  List<Object?> get props => [];
}

class TeachersRequestLoading extends TeachersRequestState {
  const TeachersRequestLoading();
}

class TeachersRequestError extends TeachersRequestState {
  const TeachersRequestError();
}

class TeachersRequestData extends TeachersRequestState {
  final List<String> teachers;

  const TeachersRequestData({required this.teachers});

  @override
  List<Object?> get props => [teachers];
}
