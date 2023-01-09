import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/free_classroom.model.dart';

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
  final List<FreeClassroom> freeCabinets;

  const FreeCabinetsData({
    required this.freeCabinets,
  });

  @override
  List<Object?> get props => [freeCabinets];
}