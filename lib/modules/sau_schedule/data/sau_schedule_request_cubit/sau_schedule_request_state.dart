import 'package:equatable/equatable.dart';

abstract class SauScheduleRequestState extends Equatable {
  const SauScheduleRequestState();

  @override
  List<Object?> get props => [];
}

class SauScheduleRequestLoading extends SauScheduleRequestState {
  const SauScheduleRequestLoading();
}

class SauScheduleRequestInternetConnectionError
    extends SauScheduleRequestState {
  const SauScheduleRequestInternetConnectionError();
}

class SauScheduleRequestUnknownError extends SauScheduleRequestState {
  const SauScheduleRequestUnknownError();
}

class SauScheduleRequestData extends SauScheduleRequestState {
  const SauScheduleRequestData();

  @override
  List<Object?> get props => [];
}
