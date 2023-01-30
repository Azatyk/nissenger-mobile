abstract class PresetsRequestState {
  const PresetsRequestState();
}

class PresetsRequestPure extends PresetsRequestState {
  const PresetsRequestPure();
}

class PresetsLoading extends PresetsRequestState {
  const PresetsLoading();
}

class PresetsUnknownError extends PresetsRequestState {
  const PresetsUnknownError();
}
