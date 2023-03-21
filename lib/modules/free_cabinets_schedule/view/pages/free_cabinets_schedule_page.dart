import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/data/repositories/free_cabinets.repository.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
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
    ThemeData theme = Theme.of(context);

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
            padding: EdgeInsets.only(
              left: 27.w,
              right: 27.w,
              top:
                  defaultTargetPlatform == TargetPlatform.android ? 30.h : 20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonHeader(
                  title:
                      "${widget.cabinetName} ${LangKeys.cabinet.translate(context)}",
                ),
                SizedBox(height: 10.h),
                Text(
                  LangKeys.cabinetsLessonsList.translate(context),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 20.h),
                BlocProvider(
                  create: (context) => FreeCabinetScheduleScrollCubit(),
                  child: Expanded(
                    child: FreeCabinetLessonsList(
                      cabinetName: widget.cabinetName,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
