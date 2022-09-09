import 'package:equatable/equatable.dart';

abstract class HiveEvent extends Equatable {
  const HiveEvent();

  @override
  List<Object?> get props => [];
}

class AppInitialized extends HiveEvent {
  const AppInitialized();
}
