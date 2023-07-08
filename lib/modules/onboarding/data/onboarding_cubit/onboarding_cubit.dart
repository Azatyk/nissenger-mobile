import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/onboarding/data/onboarding_cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState(userType: UserTypes.pure)) {
    getUserType();
  }

  void getUserType() {
    var box = Hive.box(UserSettingsBox.boxName);
    String userType = box.get(UserSettingsBox.userType);

    emit(OnboardingState(userType: userType));
  }
}
