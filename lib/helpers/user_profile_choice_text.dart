import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_state.dart';

class UserProfileChoiceText {
  static String getChoiceText({required ProfileData state}) {
    String finalText = "";

    if (state.gradeNumber == 11 || state.gradeNumber == 12) {
      finalText =
          "${state.firstProfile} | ${state.secondProfile} | ${state.thirdProfile}";
    }

    if (state.foreignLanguage != null && state.foreignLanguage != "") {
      if (finalText != "") {
        finalText = "$finalText | ${state.foreignLanguage}";
      } else {
        finalText = state.foreignLanguage.toString();
      }
    }

    return finalText;
  }
}
