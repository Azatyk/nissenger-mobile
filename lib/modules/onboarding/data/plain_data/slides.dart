import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';

class SlidesData {
  static const List<Slide> teacherSlides = [
    Slide(
      title: "Добро пожаловать!",
      subtitle:
          "Сейчас расскажем как пользоваться приложением и смотреть расписание",
      imageName: "",
      lastSlide: false,
    ),
    Slide(
      title: "Первым делом нужно познакомиться",
      subtitle: "Найдите себя в списке, а мы найдем ваше расписание",
      imageName: "",
      lastSlide: false,
    ),
    Slide(
      title: "И тут ваше расписание на всю неделю",
      subtitle: "Свайпайте налево и направо и день поменяется",
      imageName: "",
      lastSlide: false,
    ),
    Slide(
      title: "Сколько осталось до конца урока?",
      subtitle: "Мы подскажем! Перейдите в режим таймера и расслабьтесь",
      imageName: "",
      lastSlide: true,
    ),
  ];

  static const List<Slide> studentSlides = [
    Slide(
      title: "Привет, это Nissenger",
      subtitle:
          "Сейчас расскажем как пользоваться приложением и смотреть свое расписание",
      imageName: "",
      lastSlide: false,
    ),
    Slide(
      title: "Первым делом нужно познакомиться",
      subtitle: "Выбери свой класс, группу и профильные предметы",
      imageName: "",
      lastSlide: false,
    ),
    Slide(
      title: "И тут твое расписание на всю неделю",
      subtitle: "Свайпай налево и направо и день поменяется",
      imageName: "",
      lastSlide: false,
    ),
    Slide(
      title: "Сколько осталось до конца урока?",
      subtitle: "Мы подскажем! Перейди в режим таймера и расслабься",
      imageName: "",
      lastSlide: true,
    ),
  ];
}
