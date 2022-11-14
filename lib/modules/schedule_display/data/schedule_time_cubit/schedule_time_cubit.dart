// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nissenger_mobile/modules/schedule_display/data/schedule_time_cubit/schedule_time_state.dart';
// import 'package:intl/intl.dart';
// import 'package:nissenger_mobile/modules/schedule_display/data/types/lesson.dart';

// class ScheduleTimeCubit extends Cubit<ScheduleTimeState> {
//   ScheduleTimeCubit()
//       : super(
//           const ScheduleTimeState(isCurrent: false),
//         );

//   void isCurrentLessons({required Lesson currentLesson}) {
//     DateTime? convertStringToDateTime(String time) {
//       DateTime? dateTime;
//       try {
//         dateTime = DateFormat("hh:mm").parse(time);
//       } catch (e) {
//         // todo: error handling
//       }
//       return dateTime;
//     }

//     DateTime? startTime = convertStringToDateTime(currentLesson.startTime);
//     DateTime? endTime = convertStringToDateTime(currentLesson.endTime);

//     if (startTime!.isAfter(DateTime.now()) &&
//         endTime!.isBefore(DateTime.now())) {
//       emit(
//         const ScheduleTimeState(isCurrent: true),
//       );
//     }
//   }
// }
