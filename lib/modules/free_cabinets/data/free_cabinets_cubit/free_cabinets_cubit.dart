import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_cubit/free_cabinets_state.dart';

class FreeCabinetsCubit extends Cubit<FreeCabinetsState> {
  FreeCabinetsCubit() : super(const FreeCabinetsLoading()) {
    loadFreeCabinets();
  }

  void loadFreeCabinets() async {}
}
