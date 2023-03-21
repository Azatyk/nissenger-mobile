import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/data/repositories/free_cabinets.repository.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_cubit/free_cabinets_list_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_scroll_cubit/free_cabinets_list_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets/view/components/free_cabinets_list.dart';

class FreeCabinetsPage extends StatefulWidget {
  const FreeCabinetsPage({Key? key}) : super(key: key);

  @override
  State<FreeCabinetsPage> createState() => _FreeCabinetsPageState();
}

class _FreeCabinetsPageState extends State<FreeCabinetsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) => FreeCabinetsCubit(
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
                  title: LangKeys.freeCabinetsTitle.translate(context),
                ),
                SizedBox(height: 15.h),
                Text(
                  LangKeys.freeCabinetsDescription.translate(context),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 25.h),
                BlocProvider(
                  create: (context) => FreeCabinetsListScrollCubit(),
                  child: const Expanded(
                    child: FreeCabinetsList(),
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
