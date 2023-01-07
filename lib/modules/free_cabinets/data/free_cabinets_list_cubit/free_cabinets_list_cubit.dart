import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/free_classroom.model.dart';
import 'package:nissenger_mobile/data/repositories/free_cabinets.repository.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_cubit/free_cabinets_list_state.dart';

class FreeCabinetsCubit extends Cubit<FreeCabinetsState> {
  FreeCabinetsRepository freeCabinetsRepository;

  FreeCabinetsCubit({required this.freeCabinetsRepository})
      : super(const FreeCabinetsLoading()) {
    loadFreeCabinets();
  }

  void loadFreeCabinets() async {
    emit(const FreeCabinetsLoading());

    try {
      List<FreeClassroom> cabinets =
          await freeCabinetsRepository.getCabinetsList();
      emit(
        FreeCabinetsData(
          freeCabinets: cabinets,
        ),
      );
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const FreeCabinetsInternetConnectionError());
      }
    }
  }
}
