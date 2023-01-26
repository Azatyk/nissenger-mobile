import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/sau_schedule/view/components/notifications_button.dart';

import '../../data/sau_schedule_request_cubit/sau_schedule_request_cubit.dart';
import '../../data/sau_schedule_scroll_cubit/sau_schedule_scroll_cubit.dart';
import '../components/sau_list.dart';

class SauSchedulePage extends StatefulWidget {
  final bool notificationsEnabled;

  const SauSchedulePage({
    this.notificationsEnabled = true,
    Key? key,
  }) : super(key: key);

  @override
  State<SauSchedulePage> createState() => _SauSchedulePageState();
}

class _SauSchedulePageState extends State<SauSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SauScheduleRequestCubit(),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CommonHeader(
                      title: "Расписание соров",
                    ),
                    NotificationsButton(
                        notificationEnabled: widget.notificationsEnabled)
                  ],
                ),
                SizedBox(height: 25.h),
                BlocProvider(
                  create: (context) => SauScheduleScrollCubit(),
                  child: const Expanded(
                    child: SauScheduleList(),
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
