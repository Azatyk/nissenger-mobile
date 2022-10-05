import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/greeting/data/types/greeting_status.type.dart';

class GreetingState extends Equatable {
  final String userType;
  final GreetingStatus status;

  const GreetingState({
    required this.userType,
    required this.status,
  });

  @override
  List<Object?> get props => [
        userType,
        status,
      ];
}
