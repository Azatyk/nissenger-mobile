import 'package:flutter/material.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';

class SlidesData {
  static List<Slide> teacherSlides(BuildContext context) {
    return [
      Slide(
        title: LangKeys.teacherTitle1.translate(context),
        subtitle: LangKeys.teacherSubtititle1.translate(context),
        imageName: "onboarding-teacher-1.png",
        lastSlide: false,
      ),
      Slide(
        title: LangKeys.teacherTitle2.translate(context),
        subtitle: LangKeys.teacherSubtititle2.translate(context),
        imageName: "onboarding-teacher-2.png",
        lastSlide: false,
      ),
      Slide(
        title: LangKeys.teacherTitle3.translate(context),
        subtitle: LangKeys.teacherSubtititle3.translate(context),
        imageName: "onboarding-teacher-3.png",
        lastSlide: false,
      ),
      Slide(
        title: LangKeys.teacherTitle4.translate(context),
        subtitle: LangKeys.teacherSubtititle4.translate(context),
        imageName: "onboarding-teacher-4.png",
        lastSlide: true,
      ),
    ];
  }

  static List<Slide> studentSlides(BuildContext context) {
    return [
      Slide(
        title: LangKeys.studentTitle1.translate(context),
        subtitle: LangKeys.studentSubtitle1.translate(context),
        imageName: "onboarding-student-1.png",
        lastSlide: false,
      ),
      Slide(
        title: LangKeys.studentTitle2.translate(context),
        subtitle: LangKeys.studentSubtitle2.translate(context),
        imageName: "onboarding-student-2.png",
        lastSlide: false,
      ),
      Slide(
        title: LangKeys.studentTitle3.translate(context),
        subtitle: LangKeys.studentSubtitle3.translate(context),
        imageName: "onboarding-student-3.png",
        lastSlide: false,
      ),
      Slide(
        title: LangKeys.studentTitle4.translate(context),
        subtitle: LangKeys.studentSubtitle4.translate(context),
        imageName: "onboarding-student-4.png",
        lastSlide: true,
      ),
    ];
  }
}
