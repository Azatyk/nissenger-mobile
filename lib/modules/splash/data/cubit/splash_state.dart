import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/splash/data/types/push_types.dart';

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
  final PushTypes type;

  const SplashStateReadyToPush({required this.type});

  @override
  List<Object?> get props => [type];
}
