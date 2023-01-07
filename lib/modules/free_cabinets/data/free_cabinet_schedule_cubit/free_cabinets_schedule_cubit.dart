import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/repositories/free_cabinets.repository.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinet_schedule_cubit/free_cabinets_schedule_state.dart';

class FreeCabinetScheduleCubit extends Cubit<FreeCabinetScheduleState> {
  FreeCabinetsRepository freeCabinetsRepository;

  FreeCabinetScheduleCubit({
    required this.freeCabinetsRepository,
  }) : super(const FreeCabinetScheduleLoading());

  void loadFreeCabinetSchedule({required String classroom}) async {
    emit(const FreeCabinetScheduleLoading());

    try {
      List<Lesson> lessons = await freeCabinetsRepository.getCabinetSchedule(
        classroom: classroom,
      );
      emit(
        FreeCabinetScheduleData(
          freeCabinetLessons: lessons,
        ),
      );
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const FreeCabinetScheduleInternetConnectionError());
      }
    }
  }
}
