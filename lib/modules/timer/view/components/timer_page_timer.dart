import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_cubit.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_state.dart';
import 'package:nissenger_mobile/modules/timer/data/types/timer_types.dart';

class TimerPageTimer extends StatelessWidget {
  const TimerPageTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<TimerCubit, TimerState>(builder: (context, state) {
      String minutesString = "00";
      String secondsString = "00";

      String timerText = "";

      if (state is TimerRunInProgress) {
        minutesString =
            ((state.duration / 60) % 60).floor().toString().padLeft(2, "0");
        secondsString =
            (state.duration % 60).floor().toString().padLeft(2, "0");

        if (state.type == TimerActiveTypes.lesson) {
          timerText = "осталось до конца\n урока";
        } else if (state.type == TimerActiveTypes.timeout) {
          timerText = "осталось до конца\n перемены";
        }
      } else if (state is TimerDiactive) {
        if (state.type == TimerDiactiveTypes.noLessonsToday) {
          timerText = "сегодня уроков нет";
        } else if (state.type == TimerDiactiveTypes.beforeLessons) {
          timerText = "Уроки ещё\nне начались";
        } else if (state.type == TimerDiactiveTypes.afterLessons) {
          timerText = "На сегодня уроки\nзакончились";
        }
      } else if(state is TimerPure) {
        timerText = "Загружаем расписание";
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$minutesString:$secondsString",
            style: theme.textTheme.displayLarge,
          ),
          SizedBox(height: 10.h),
          Text(
            timerText,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.surface,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          )
        ],
      );
    });
  }
}
