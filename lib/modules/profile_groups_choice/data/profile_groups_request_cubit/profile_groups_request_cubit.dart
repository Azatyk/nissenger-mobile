import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/data/models/profile_groups.model.dart';
import 'package:nissenger_mobile/data/repositories/user_settings.repository.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_request_cubit/profile_groups_request_state.dart';

class ProfileGroupsRequestCubit extends Cubit<ProfileGroupsRequestState> {
  UserSettingsRepository repository;

  ProfileGroupsRequestCubit({required this.repository})
      : super(const ProfileGroupsRequestLoading()) {
    loadProfileGroups();
  }

  void loadProfileGroups() async {
    emit(const ProfileGroupsRequestLoading());

    try {
      var box = Hive.box(UserSettingsBox.boxName);

      int gradeNumber = box.get(UserSettingsBox.gradeNumber);
      String gradeLetter = box.get(UserSettingsBox.gradeLetter);

      String firstProfileSubject = box.get(UserSettingsBox.firstMainProfile);
      String secondProfileSubject = box.get(UserSettingsBox.secondMainProfile);
      String? thirdProfileSubject = box.get(UserSettingsBox.thirdProfile);

      if (thirdProfileSubject == "мат10") {
        box.put(UserSettingsBox.thirdProfile, thirdProfileSubject);
      }

      List<ProfileGroups> profileGroups = await repository.getProfileGroups(
        subjects: thirdProfileSubject != null && thirdProfileSubject != "мат10"
            ? [
                firstProfileSubject,
                secondProfileSubject,
                thirdProfileSubject,
              ]
            : [
                firstProfileSubject,
                secondProfileSubject,
              ],
        gradeNumber: gradeNumber,
        gradeLetter: gradeLetter,
      );

      emit(
        ProfileGroupsRequestData(
          profileGroups: profileGroups,
          thirdProfileExtendedMath: thirdProfileSubject == "мат10",
          thirdProfileGroupExist: profileGroups.length == 2,
        ),
      );
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const ProfileGroupsInternetConnectionError());
      } else {
        emit(const ProfileGroupsUnknownError());
      }
    }
  }
}
