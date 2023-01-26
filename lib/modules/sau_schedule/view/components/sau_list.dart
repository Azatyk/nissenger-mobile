import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/helpers/error_messages.dart';
import 'package:nissenger_mobile/modules/sau_schedule/data/mock_data/sau_mock_data.dart';
import 'package:nissenger_mobile/modules/sau_schedule/data/sau_schedule_scroll_cubit/sau_schedule_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/sau_schedule/view/components/sau_day.dart';
import '../../data/sau_schedule_request_cubit/sau_schedule_request_cubit.dart';
import '../../data/sau_schedule_request_cubit/sau_schedule_request_state.dart';
import '../../data/sau_schedule_scroll_cubit/sau_schedule_scroll_state.dart';

class SauScheduleList extends StatefulWidget {
  const SauScheduleList({Key? key}) : super(key: key);

  @override
  State<SauScheduleList> createState() => _SauScheduleListState();
}

class _SauScheduleListState extends State<SauScheduleList>
    with WidgetsBindingObserver {
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(scrollListener);

    BlocProvider.of<SauScheduleScrollCubit>(context).reachTop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToTop();
    });

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  void scrollListener() {
    var currentState = context.read<SauScheduleScrollCubit>().state;

    if (controller.offset > controller.position.minScrollExtent &&
        !controller.position.outOfRange &&
        currentState is SauScheduleScrollHideBorder) {
      BlocProvider.of<SauScheduleScrollCubit>(context, listen: false)
          .scrollToBottom();
    } else if (controller.offset <= controller.position.minScrollExtent &&
        currentState is SauScheduleScrollShowBorder) {
      BlocProvider.of<SauScheduleScrollCubit>(context, listen: false)
          .reachTop();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      scrollToTop();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void scrollToTop() {
    if (controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 1),
        curve: Curves.bounceInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocConsumer<SauScheduleRequestCubit, SauScheduleRequestState>(
      listenWhen: (prevState, newState) =>
          newState is SauScheduleRequestInternetConnectionError,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackbar(
            text: "Нет интернет соединения",
            theme: theme,
          ),
        );
      },
      builder: (context, state) {
        if (state is SauScheduleRequestLoading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: SizedBox(
                width: 40.r,
                height: 40.r,
                child: CircularProgressIndicator(
                  strokeWidth: 6.r,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          );
        } else if (state is SauScheduleRequestData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SauScheduleScrollCubit, SauScheduleScrollState>(
                builder: (context, state) =>
                    state is SauScheduleScrollShowBorder
                        ? const DashedDivider()
                        : SizedBox(height: 1.h),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...saus
                          .map(
                            (sauDay) => Column(
                              children: [
                                SauDay(
                                  day: sauDay.day,
                                  date: sauDay.date,
                                  sauList: sauDay.saus,
                                  isToday: sauDay.isToday,
                                ),
                                SizedBox(height: 14.h),
                              ],
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is SauScheduleRequestInternetConnectionError ||
            state is SauScheduleRequestUnknownError) {
          return ErrorBlock(
            errorType: state is SauScheduleRequestInternetConnectionError
                ? ErrorTypes.internetConnectionError
                : ErrorTypes.unknownError,
            onMainButtonPressed: () =>
                BlocProvider.of<SauScheduleRequestCubit>(context).loadSauList(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
