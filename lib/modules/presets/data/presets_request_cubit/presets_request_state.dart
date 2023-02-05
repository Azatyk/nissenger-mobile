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
  final Preset? activePreset;

  const PresetsRequestData({
    required this.presets,
    required this.activePreset,
  });

  @override
  List<Object?> get props => [presets];
}

class PresetsUnknownError extends PresetsRequestState {
  const PresetsUnknownError();
}
