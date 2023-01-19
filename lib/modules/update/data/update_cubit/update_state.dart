abstract class UpdateState {
  const UpdateState();
}

class UpdatePure extends UpdateState {
  const UpdatePure();
}

class UpdateInternetConnectionError extends UpdateState {
  const UpdateInternetConnectionError();
}

class UpdateUnknownError extends UpdateState {
  const UpdateUnknownError();
}
