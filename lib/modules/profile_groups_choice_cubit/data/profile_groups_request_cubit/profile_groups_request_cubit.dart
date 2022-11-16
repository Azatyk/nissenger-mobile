import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/plain_data/profile_names.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_request_cubit/profile_groups_request_state.dart';

class ProfileGroupsRequestCubit extends Cubit<ProfileGroupsRequestState> {
  ProfileGroupsRequestCubit() : super(const ProfileGroupsRequestLoading()) {
    loadProfileGroups(); 
  }

  void loadProfileGroups() async {
    emit(const ProfileGroupsRequestLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(
        ProfileGroupsRequestData(
          profileGroups: MockProfileGroups.getProfileGroups(),
        ),
      );
    } catch (err) {
      // to do: handle error
    }
  }
}
