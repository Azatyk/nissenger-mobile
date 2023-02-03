import 'package:hive/hive.dart';

part 'preset_hive_class.g.dart';

@HiveType(typeId: 0)
class Preset extends HiveObject {
  @HiveField(0)
  int gradeNumber;
  @HiveField(1)
  String gradeLetter;
  @HiveField(2)
  int gradeGroup;
  @HiveField(3)
  List<String> foreignLanguages;
  @HiveField(4)
  String firstMainProfile;
  @HiveField(5)
  String secondMainProfile;
  @HiveField(6)
  String thirdProfile;
  @HiveField(7)
  String firstProfileGroup;
  @HiveField(8)
  String secondProfileGroup;
  @HiveField(9)
  String thirdProfileGroup;
  @HiveField(10)
  String teacherName;
  @HiveField(11)
  String presetName;

  Preset(
    this.gradeNumber,
    this.gradeLetter,
    this.gradeGroup,
    this.foreignLanguages,
    this.firstMainProfile,
    this.secondMainProfile,
    this.thirdProfile,
    this.firstProfileGroup,
    this.secondProfileGroup,
    this.thirdProfileGroup,
    this.teacherName,
    this.presetName,
  );
}
