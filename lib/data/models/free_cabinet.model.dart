import 'package:nissenger_mobile/data/models/cabinet.model.dart';

class FreeCabinet {
  final Cabinet cabinet;
  final bool isFree;
  final int lessonsLeft;

  const FreeCabinet(
      {required this.cabinet, required this.isFree, required this.lessonsLeft});
}
