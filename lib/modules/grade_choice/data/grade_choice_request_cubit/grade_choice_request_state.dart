abstract class GradeChoiceRequestState {
  const GradeChoiceRequestState();
}

class GradeChoiceRequestPure extends GradeChoiceRequestState {
  const GradeChoiceRequestPure();
}

class GradeChoiceGradeExistingLoading extends GradeChoiceRequestState {
  const GradeChoiceGradeExistingLoading();
}

class GradeChoiceGradeCheckingFailed extends GradeChoiceRequestState {
  const GradeChoiceGradeCheckingFailed();
}

class GradeChoiceGradeCheckingInternetConnectionError
    extends GradeChoiceRequestState {
  const GradeChoiceGradeCheckingInternetConnectionError();
}

class GradeChoiceGradeCheckingUnknownError extends GradeChoiceRequestState {
  const GradeChoiceGradeCheckingUnknownError();
}

class GradeChoiceGradeExistingChecked extends GradeChoiceRequestState {
  const GradeChoiceGradeExistingChecked();
}

class GradeChoiceRequestReadyToPush extends GradeChoiceRequestState {
  const GradeChoiceRequestReadyToPush();
}
