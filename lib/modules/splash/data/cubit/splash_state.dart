import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashStateLoading extends SplashState {
  const SplashStateLoading();
}

class SplashStateInternetConnectionError extends SplashState {
  const SplashStateInternetConnectionError();
}

class SplashStateUnknownError extends SplashState {
  const SplashStateUnknownError();
}

class SplashStateReadyToPush extends SplashState {
  final String mode;

  const SplashStateReadyToPush({
    required this.mode,
  });

  @override
  List<Object?> get props => [mode];
}

class SplashStateUpdateRequired extends SplashState {
  const SplashStateUpdateRequired();
}

class SplashStateUnauthorized extends SplashState {
  const SplashStateUnauthorized();
}
