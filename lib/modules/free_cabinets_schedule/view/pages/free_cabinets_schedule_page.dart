import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/data/repositories/free_cabinets.repository.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_cubit/free_cabinets_schedule_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_scroll_cubit/free_cabinet_schedule_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/view/components/free_cabinet_lessons_list.dart';

class FreeCabinetsSchedulePage extends StatefulWidget {
  final String cabinetName;
  const FreeCabinetsSchedulePage({required this.cabinetName, Key? key})
      : super(key: key);

  @override
  State<FreeCabinetsSchedulePage> createState() =>
      _FreeCabinetsSchedulePageState();
}

class _FreeCabinetsSchedulePageState extends State<FreeCabinetsSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FreeCabinetScheduleCubit(
        freeCabinetsRepository: FreeCabinetsRepository(),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 27.w,
              vertical:
                  defaultTargetPlatform == TargetPlatform.android ? 30.h : 20.h,
            ),
            child: BlocProvider(
              create: (context) => FreeCabinetScheduleScrollCubit(),
              child: FreeCabinetLessonsList(
                cabinetName: widget.cabinetName,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
