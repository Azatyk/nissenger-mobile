import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_state.dart';

class UserProfileChoiceText {
  static String getChoiceText({required ProfileData state}) {
    String finalText = "";

    if (state.gradeNumber == 11 || state.gradeNumber == 12) {
      finalText =
          "${state.firstProfile} | ${state.secondProfile} | ${state.thirdProfile == 'мат10' ? 'Мат 10 ч.' : state.thirdProfile}";
    } else if (state.gradeNumber == 10) {
      finalText = state.firstProfileGroup.toString();
    }

    if (state.foreignLanguages != null && state.foreignLanguages!.isNotEmpty) {
      if (finalText != "") {
        finalText = "$finalText |";
      }

      for (int i = 0; i < state.foreignLanguages!.length; i++) {
        finalText = "$finalText ${state.foreignLanguages![i]}";

        if (i != state.foreignLanguages!.length - 1) {
          finalText = "$finalText |";
        }
      }
    }

    return finalText;
  }
}
