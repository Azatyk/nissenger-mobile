import 'package:nissenger_mobile/common/constants/profile_lessons.dart';

class ProfileLessonsSeperator {
  static List<String> separateMainProfileLessons({
    required String mainProfileLessons,
    required List<String> profileLessonsNames,
  }) {
    String firstProfileLesson = "";
    String secondProfileLesson = "";

    if (mainProfileLessons == profileLessonsNames[0]) {
      firstProfileLesson = ProfileLessons.physics;
      secondProfileLesson = ProfileLessons.ict;
    } else if (mainProfileLessons == profileLessonsNames[1]) {
      firstProfileLesson = ProfileLessons.chemistry;
      secondProfileLesson = ProfileLessons.biology;
    } else if (mainProfileLessons == profileLessonsNames[2]) {
      firstProfileLesson = ProfileLessons.physics;
      secondProfileLesson = ProfileLessons.biology;
    } else if (mainProfileLessons == profileLessonsNames[3]) {
      firstProfileLesson = ProfileLessons.physics;
      secondProfileLesson = ProfileLessons.chemistry;
    } else if (mainProfileLessons == profileLessonsNames[4]) {
      firstProfileLesson = ProfileLessons.ict;
      secondProfileLesson = ProfileLessons.chemistry;
    } else if (mainProfileLessons == profileLessonsNames[5]) {
      firstProfileLesson = ProfileLessons.ict;
      secondProfileLesson = ProfileLessons.biology;
    }

    return [
      firstProfileLesson,
      secondProfileLesson,
    ];
  }
}
