import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/greeting/data/types/greeting_status.dart';

class GreetingState extends Equatable {
  final GreetingStatus status;

  const GreetingState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
