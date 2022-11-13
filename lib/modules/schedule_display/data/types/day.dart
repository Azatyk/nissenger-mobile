import 'package:nissenger_mobile/modules/schedule_display/data/types/lesson.dart';

class Day {
  final String daynum;
  final String dayname;
  final List<Lesson> lessons;

  Day(this.daynum, this.dayname, this.lessons);
}
