import 'package:equatable/equatable.dart';
import '../../../../config/preset_hive_class.dart';

abstract class PresetsRequestState extends Equatable {
  const PresetsRequestState();

  @override
  List<Object?> get props => [];
}

class PresetsRequestPure extends PresetsRequestState {
  const PresetsRequestPure();
}

class PresetsLoading extends PresetsRequestState {
  const PresetsLoading();
}

class PresetsRequestData extends PresetsRequestState {
  final List<Preset?> presets;

  const PresetsRequestData({
    required this.presets,
  });

  @override
  List<Object?> get props => [presets];
}

class PresetsInternetConnectionError extends PresetsRequestState {
  const PresetsInternetConnectionError();
}

class PresetsUnknownError extends PresetsRequestState {
  const PresetsUnknownError();
}
