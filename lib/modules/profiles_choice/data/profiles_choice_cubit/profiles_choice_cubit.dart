import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/helpers/profile_lessons_sepertor.dart';
import 'package:nissenger_mobile/modules/profiles_choice_cubit/data/plain_data/profile_options.dart';
import 'package:nissenger_mobile/modules/profiles_choice_cubit/data/profiles_choice_cubit/profiles_choice_state.dart';

class ProfilesChoiceCubit extends Cubit<ProfilesChoiceState> {
  ProfilesChoiceCubit()
      : super(
          const ProfilesChoicePure(),
        );

  void saveProfileChoice({
    required String mainProfiles,
    required String thirdProfile,
  }) {
    var box = Hive.box(UserSettingsBox.boxName);

    List<String> convertedProfileLessons =
        ProfileLessonsSeperator.separateMainProfileLessons(
      mainProfileLessons: mainProfiles,
      profileLessonsNames: ProfileOptions.profileLessonsNames,
    );

    String firstMainProfile = convertedProfileLessons[0];
    String secondMainProfile = convertedProfileLessons[1];

    box.put(UserSettingsBox.firstMainProfile, firstMainProfile);
    box.put(UserSettingsBox.secondMainProfile, secondMainProfile);
    if (thirdProfile == "Математика 10 ч.") {
      box.put(UserSettingsBox.thirdProfile, "мат10");
      box.put(UserSettingsBox.thirdProfileGroup, "мат10");
    } else {
      box.put(UserSettingsBox.thirdProfile, thirdProfile);
    }

    emit(
      const ProfilesChoiceReadyToPush(),
    );

    emit(
      const ProfilesChoicePure(),
    );
  }
}
