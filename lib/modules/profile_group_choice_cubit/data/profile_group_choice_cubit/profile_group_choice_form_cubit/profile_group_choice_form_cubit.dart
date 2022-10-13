import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/profile_group_choice_cubit/data/profile_group_choice_cubit/profile_group_choice_form_cubit/profile_group_choice_form_state.dart';

class ProfileGroupChoiceFormCubit extends Cubit<ProfileGroupChoiceFormState> {
  ProfileGroupChoiceFormCubit()
      : super(
          const ProfileGroupChoiceFormState(
            firstGroup: 0, 
            secondGroup: 0, 
            thirdGroup: 0, 
          ),
        );

  void changeFirstGroup({required int firstGroup}) {
    emit(
      state.copyWith(firstGroup: firstGroup),
    );
  }

  void changeSecondGroup({required int secondGroup}) {
    emit(
      state.copyWith(secondGroup: secondGroup),
    );
  }

  void changeThirdGroup({required int thirdGroup}) {
    emit(
      state.copyWith(thirdGroup: thirdGroup),
    );
  }
}
