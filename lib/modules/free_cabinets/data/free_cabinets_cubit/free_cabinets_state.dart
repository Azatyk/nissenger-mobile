import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/types/free_cabinet_model.dart';

abstract class FreeCabinetsState extends Equatable {
  const FreeCabinetsState();

  @override
  List<Object?> get props => [];
}

class FreeCabinetsLoading extends FreeCabinetsState {
  const FreeCabinetsLoading();
}

class FreeCabinetsInternetConnectionError extends FreeCabinetsState {
  const FreeCabinetsInternetConnectionError();
}

class FreeCabinetsData extends FreeCabinetsState {
  final List<FreeCabinet> freeCabinets;

  const FreeCabinetsData({
    required this.freeCabinets,
  });

  @override
  List<Object?> get props => [freeCabinets];
}
