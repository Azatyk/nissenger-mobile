import 'package:nissenger_mobile/data/models/lesson.model.dart';

class Schedule {
  final List<List<Lesson>> days;

  const Schedule({
    required this.days,
  });
}
