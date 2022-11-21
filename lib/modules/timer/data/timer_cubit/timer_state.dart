import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/modules/timer/data/types/timer_types.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object?> get props => [];
}

class TimerPure extends TimerState {
  const TimerPure();
}

class TimerChangeDuration extends TimerState {
  final Schedule schedule;

  const TimerChangeDuration({required this.schedule});

  @override
  List<Object?> get props => [schedule];
}

class TimerRunInProgress extends TimerState {
  final int duration;
  final TimerActiveTypes type;

  const TimerRunInProgress({
    required this.duration,
    required this.type,
  });

  @override
  List<Object?> get props => [
        duration,
        type,
      ];

  TimerRunInProgress copyWith({
    int? duration,
    TimerActiveTypes? type,
  }) {
    return TimerRunInProgress(
      duration: duration ?? this.duration,
      type: type ?? this.type,
    );
  }
}

class TimerDiactive extends TimerState {
  final TimerDiactiveTypes type;

  const TimerDiactive({required this.type});

  @override
  List<Object?> get props => [type];
}
