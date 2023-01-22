import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/repositories/feature_toggles.repository.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_feature_toggle_cubit/grade_choice_feature_toggle_state.dart';

class GradeChoiceFeatureToggleCubit
    extends Cubit<GradeChoiceFeatureToggleState> {
  FeatureTogglesRepository repository;

  GradeChoiceFeatureToggleCubit({required this.repository})
      : super(const GradeChoiceFeatureTogglePure());

  void checkIsForeignLanguageEnabled() async {
    try {
      final bool isEnabled = await repository.getForeignLanguageToggle();

      if (isEnabled) {
        emit(const GradeChoiceFeatureToggleForeignLanguageEnabled());
      } else {
        emit(const GradeChoiceFeatureTogglePure());
      }
    } catch (error) {
      emit(const GradeChoiceFeatureToggleError());
    }
  }
}
