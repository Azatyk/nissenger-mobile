import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/splash/data/types/splash_status.dart';

class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
