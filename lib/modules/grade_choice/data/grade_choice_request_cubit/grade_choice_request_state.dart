abstract class GradeChoiceRequestState {
  const GradeChoiceRequestState();
}

class GradeChoiceRequestPure extends GradeChoiceRequestState {
  const GradeChoiceRequestPure();
}

class GradeChoiceGradeExistingLoading extends GradeChoiceRequestState {
  const GradeChoiceGradeExistingLoading();
}

class GradeChoiceGradeExistingChecked extends GradeChoiceRequestState {
  const GradeChoiceGradeExistingChecked();
}

class GradeChoiceRequestReadyToPush extends GradeChoiceRequestState {
  const GradeChoiceRequestReadyToPush();
}
