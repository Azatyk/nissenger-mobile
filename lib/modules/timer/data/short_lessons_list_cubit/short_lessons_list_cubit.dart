import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/data/repositories/schedule.repository.dart';
import 'package:nissenger_mobile/helpers/schedule_parser.dart';
import 'package:nissenger_mobile/helpers/active_lesson_finder.dart';
import 'package:nissenger_mobile/modules/timer/data/short_lessons_list_cubit/short_lessons_list_state.dart';
import 'package:nissenger_mobile/modules/timer/data/types/short_lessons_list_types.dart';

import '../../../../config/preset_hive_class.dart';

class ShortLessonsListCubit extends Cubit<ShortLessonsListState> {
  ScheduleRepository repository;

  ShortLessonsListCubit({required this.repository})
      : super(const ShortLessonsListRequestLoading()) {
    loadSchedule();
  }

  void loadSchedule() async {
    emit(const ShortLessonsListRequestLoading());

    var box = Hive.box(UserSettingsBox.boxName);
    var activePresetBox = Hive.box<Preset?>(ActivePresetBox.boxName);

    Preset? activePreset = Preset(
      box.get(UserSettingsBox.gradeNumber) ?? 0,
      box.get(UserSettingsBox.gradeLetter) ?? "",
      box.get(UserSettingsBox.gradeGroup) ?? 0,
      box.get(UserSettingsBox.foreignLanguages) ?? [],
      box.get(UserSettingsBox.firstMainProfile) ?? "",
      box.get(UserSettingsBox.secondMainProfile) ?? "",
      box.get(UserSettingsBox.thirdProfile) ?? "",
      box.get(UserSettingsBox.firstProfileGroup) ?? "",
      box.get(UserSettingsBox.secondProfileGroup) ?? "",
      box.get(UserSettingsBox.thirdProfileGroup) ?? "",
      box.get(UserSettingsBox.teacherName) ?? "",
      box.get(UserSettingsBox.presetName) ?? "",
      box.get(UserSettingsBox.userType) ?? "",
    );

    if (activePresetBox.length > 0) {
      activePreset = activePresetBox.getAt(0);
    } else if (activePresetBox.length == 0) {
      activePresetBox.add(activePreset);
    }

    String userType = activePreset!.userType;

    int gradeNumber = activePreset.gradeNumber;
    String gradeLetter = activePreset.gradeLetter;
    int gradeGroup = activePreset.gradeGroup;
    String firstProfileGroup = activePreset.firstProfileGroup;
    String secondProfileGroup = activePreset.secondProfileGroup;
    String thirdProfileGroup = activePreset.thirdProfileGroup;
    List<String> foreignLanguage = activePreset.foreignLanguages;

    String teacher = activePreset.teacherName;

    try {
      late Schedule schedule;

      if (userType == UserTypes.student) {
        schedule = ScheduleParser.addWindows(
          schedule: await repository.getStudentSchedule(
            gradeNumber: gradeNumber,
            gradeLetter: gradeLetter,
            gradeGroup: gradeGroup,
            profileGroups: [
              firstProfileGroup,
              secondProfileGroup,
              thirdProfileGroup,
            ],
            foreignLanguage: foreignLanguage,
          ),
        );
      } else if (userType == UserTypes.teacher) {
        schedule = ScheduleParser.addWindows(
          schedule: ScheduleParser.joinSameTimeLessons(
            schedule: await repository.getTeacherSchedule(teacher: teacher),
          ),
        );
      }

      emit(
        ShortLessonsListRequestData(
          schedule: schedule,
        ),
      );

      getLessons(schedule: schedule);
    } on DioError catch (err) {
      if (err.response?.statusCode == 404) {
        emit(const ShortLessonsListNotFoundError());
      } else {
        emit(const ShortLessonsListUnknownError());
      }
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const ShortLessonsListInternetConnectionError());
      } else {
        emit(const ShortLessonsListUnknownError());
      }
    }
  }

  void getLessons({required Schedule schedule}) {
    DateTime currentTime = DateTime.now();

    List<Lesson> todayLessons =
        currentTime.weekday != 7 ? schedule.days[currentTime.weekday - 1] : [];

    if (todayLessons.isEmpty) {
      // in case of no lessons today
      emit(
        ShortLessonsListData(
          threeLessons: (currentTime.weekday != 6 && currentTime.weekday != 7)
              ? schedule.days[currentTime.weekday].take(3).toList()
              : schedule.days[0].take(3).toList(),
          numberOfRemainedLessons:
              (currentTime.weekday != 6 && currentTime.weekday != 7)
                  ? schedule.days[currentTime.weekday].length - 3
                  : schedule.days[0].length - 3,
          lastLessonEndTime:
              (currentTime.weekday != 6 && currentTime.weekday != 7)
                  ? schedule
                      .days[currentTime.weekday]
                          [schedule.days[currentTime.weekday].length - 1]
                      .time
                  : schedule.days[0][schedule.days[0].length - 1].time,
          type: ShortLessonsListTypes.afterLessons,
          activeLessonIndex: -1,
          titleMonday: currentTime.weekday == 6,
        ),
      );
    } else if (currentTime.hour < todayLessons[0].time.startTimeHour ||
        (currentTime.hour == todayLessons[0].time.startTimeHour &&
            currentTime.minute < todayLessons[0].time.startTimeMinute)) {
      // in case of checking timer before today lessons
      emit(
        ShortLessonsListData(
          threeLessons: todayLessons.take(3).toList(),
          numberOfRemainedLessons: todayLessons.length - 3,
          lastLessonEndTime: todayLessons[todayLessons.length - 1].time,
          type: ShortLessonsListTypes.beforeLessons,
          activeLessonIndex: -1,
        ),
      );
    } else if (currentTime.hour >
            todayLessons[todayLessons.length - 1].time.endTimeHour ||
        (currentTime.hour ==
                todayLessons[todayLessons.length - 1].time.endTimeHour &&
            currentTime.minute >=
                todayLessons[todayLessons.length - 1].time.endTimeMinute)) {
      // in case if checking timer after today lessons
      emit(
        ShortLessonsListData(
          threeLessons: (currentTime.weekday != 5 &&
                  currentTime.weekday != 6 &&
                  currentTime.weekday != 7)
              ? schedule.days[currentTime.weekday].take(3).toList()
              : schedule.days[0].take(3).toList(),
          numberOfRemainedLessons: (currentTime.weekday != 5 &&
                  currentTime.weekday != 6 &&
                  currentTime.weekday != 7)
              ? schedule.days[currentTime.weekday].length - 3
              : schedule.days[0].length - 3,
          lastLessonEndTime: (currentTime.weekday != 5 &&
                  currentTime.weekday != 6 &&
                  currentTime.weekday != 7)
              ? schedule
                  .days[currentTime.weekday]
                      [schedule.days[currentTime.weekday].length - 1]
                  .time
              : schedule.days[0][schedule.days[0].length - 1].time,
          type: ShortLessonsListTypes.afterLessons,
          activeLessonIndex: -1,
          titleMonday: currentTime.weekday == 5,
        ),
      );
    } else {
      // in case if checking timer during lessons
      LessonTime lastLessonEndTime = todayLessons[todayLessons.length - 1].time;
      if (ActiveLessonFinder.isCurrentTimeInLesson(lesson: todayLessons[0]) ||
          ActiveLessonFinder.isCurrentTimeInWindow(
              windowLesson: todayLessons[0])) {
        // in case if active lesson is first
        emit(
          ShortLessonsListData(
            threeLessons: todayLessons.take(3).toList(),
            numberOfRemainedLessons: todayLessons.length - 3,
            lastLessonEndTime: lastLessonEndTime,
            type: ShortLessonsListTypes.duringLessons,
            activeLessonIndex: 0,
          ),
        );
      } else if (ActiveLessonFinder.isCurrentTimeInLesson(
          lesson: todayLessons[todayLessons.length - 1])) {
        // in case if active lesson is last
        emit(
          ShortLessonsListData(
            threeLessons: todayLessons
                .getRange(todayLessons.length - 3, todayLessons.length)
                .toList(),
            numberOfRemainedLessons: 0,
            lastLessonEndTime: lastLessonEndTime,
            type: ShortLessonsListTypes.duringLessons,
            activeLessonIndex: 2,
          ),
        );
      } else if (ActiveLessonFinder.isCurrentTimeInLesson(
              lesson: todayLessons[todayLessons.length - 2]) ||
          ActiveLessonFinder.isCurrentTimeInWindow(
              windowLesson: todayLessons[todayLessons.length - 2])) {
        // in case if active lesson is one before last
        emit(
          ShortLessonsListData(
            threeLessons: todayLessons
                .getRange(todayLessons.length - 3, todayLessons.length)
                .toList(),
            numberOfRemainedLessons: 0,
            lastLessonEndTime: lastLessonEndTime,
            type: ShortLessonsListTypes.duringLessons,
            activeLessonIndex: 1,
          ),
        );
      } else if (ActiveLessonFinder.isCurrentTimeInTimeoutBetweenLessons(
          finishedLesson: todayLessons[todayLessons.length - 2],
          startingLesson: todayLessons[todayLessons.length - 1])) {
        // in case if active timeout is one before last lesson
        emit(
          ShortLessonsListData(
            threeLessons: todayLessons
                .getRange(todayLessons.length - 3, todayLessons.length)
                .toList(),
            numberOfRemainedLessons: 0,
            lastLessonEndTime: lastLessonEndTime,
            type: ShortLessonsListTypes.duringLessons,
            activeLessonIndex: 1,
            isTimeout: true,
          ),
        );
      } else {
        // in case if active lesson in middle
        int activeLessonIndex = -1;

        for (int i = 1; i < todayLessons.length - 1; i++) {
          if (ActiveLessonFinder.isCurrentTimeInLesson(
                  lesson: todayLessons[i]) ||
              ActiveLessonFinder.isCurrentTimeInWindow(
                  windowLesson: todayLessons[i])) {
            activeLessonIndex = i;

            emit(
              ShortLessonsListData(
                threeLessons: todayLessons.getRange(i, i + 3).toList(),
                numberOfRemainedLessons: todayLessons.length - (i + 3),
                lastLessonEndTime: lastLessonEndTime,
                type: ShortLessonsListTypes.duringLessons,
                activeLessonIndex: 0,
              ),
            );

            break;
          }
        }

        if (activeLessonIndex == -1) {
          for (int i = 0; i < todayLessons.length; i++) {
            if (i != todayLessons.length - 1) {
              if (ActiveLessonFinder.isCurrentTimeInTimeoutBetweenLessons(
                  finishedLesson: todayLessons[i],
                  startingLesson: todayLessons[i + 1])) {
                emit(
                  ShortLessonsListData(
                    threeLessons: todayLessons.getRange(i, i + 3).toList(),
                    numberOfRemainedLessons: todayLessons.length - (i + 3),
                    lastLessonEndTime: lastLessonEndTime,
                    type: ShortLessonsListTypes.duringLessons,
                    activeLessonIndex: 0,
                    isTimeout: true,
                  ),
                );

                break;
              }
            }
          }
        }
      }
    }
  }
}
