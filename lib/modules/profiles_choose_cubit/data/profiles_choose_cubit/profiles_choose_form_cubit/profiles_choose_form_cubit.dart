import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choose_cubit/profiles_choose_form_cubit/profiles_choose_form_state.dart';

class ProfilesChooseFormCubit extends Cubit<ProfilesChooseFormState> {
  ProfilesChooseFormCubit()
      : super(
          const ProfilesChooseFormState(
            mainProfiles: 0,
            thirdProfile: 0,
          ),
        );

  void changeMainProfiles({required int mainProfiles}) {
    emit(
      state.copyWith(mainProfiles: mainProfiles),
    );
  }

  void changeThirdProfile({required int thirdProfile}) {
    emit(
      state.copyWith(thirdProfile: thirdProfile),
    );
  }
}
