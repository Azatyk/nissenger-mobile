import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashStateLoading extends SplashState {
  const SplashStateLoading();
}

class SplashStateError extends SplashState {
  const SplashStateError();
}

class SplashStateReadyToPush extends SplashState {
  final bool authorized;
  final String mode;

  const SplashStateReadyToPush({
    required this.authorized,
    this.mode = AppModes.schedule,
  });

  @override
  List<Object?> get props => [
        authorized,
        mode,
      ];
}
