import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_cubit/free_cabinets_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/mock_data/mock_cabinets.dart';
import 'package:nissenger_mobile/modules/free_cabinets/view/components/free_cabinets_list.dart';

class FreeCabinetsPage extends StatefulWidget {
  const FreeCabinetsPage({Key? key}) : super(key: key);

  @override
  State<FreeCabinetsPage> createState() => _FreeCabinetsPageState();
}

class _FreeCabinetsPageState extends State<FreeCabinetsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FreeCabinetsCubit(),
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
                vertical: defaultTargetPlatform == TargetPlatform.android
                    ? 30.h
                    : 20.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonHeader(
                          title: "Свободные кабинеты",
                        ),
                        SizedBox(height: 25.h),
                        Expanded(
                            child: FreeCabinetsList(
                          freeCabinets: cabinetsMockList,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
