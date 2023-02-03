import '../../../../config/preset_hive_class.dart';

abstract class PresetsRequestState {
  const PresetsRequestState();
}

class PresetsRequestPure extends PresetsRequestState {
  const PresetsRequestPure();
}

class PresetsLoading extends PresetsRequestState {
  const PresetsLoading();
}

class PresetsRequestData extends PresetsRequestState {
  final List<Preset?> presets;

  const PresetsRequestData({required this.presets});

  @override
  List<Object?> get props => [presets];
}

class PresetsUnknownError extends PresetsRequestState {
  const PresetsUnknownError();
}
