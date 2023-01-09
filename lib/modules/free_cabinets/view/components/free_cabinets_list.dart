import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_choice_button.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_scroll_cubit/free_cabinets_list_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_scroll_cubit/free_cabinets_list_scroll_state.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_cubit/free_cabinets_schedule_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_cubit/free_cabinets_list_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_cubit/free_cabinets_list_state.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/view/pages/free_cabinets_schedule_page.dart';

class FreeCabinetsList extends StatefulWidget {
  const FreeCabinetsList({
    Key? key,
  }) : super(key: key);

  @override
  State<FreeCabinetsList> createState() => _FreeCabinetsListState();
}

class _FreeCabinetsListState extends State<FreeCabinetsList>
    with WidgetsBindingObserver {
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(scrollListener);

    BlocProvider.of<FreeCabinetsListScrollCubit>(context).reachTop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToTop();
    });

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void scrollListener() {
    var currentState = context.read<FreeCabinetsListScrollCubit>().state;

    if (controller.offset > controller.position.minScrollExtent &&
        !controller.position.outOfRange &&
        currentState is FreeCabinetsListScrollHideBorder) {
      BlocProvider.of<FreeCabinetsListScrollCubit>(context, listen: false)
          .scrollToBottom();
    } else if (controller.offset <= controller.position.minScrollExtent &&
        currentState is FreeCabinetsListScrollShowBorder) {
      BlocProvider.of<FreeCabinetsListScrollCubit>(context, listen: false)
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

    return BlocConsumer<FreeCabinetsCubit, FreeCabinetsState>(
      listenWhen: (prevState, newState) =>
          newState is FreeCabinetsInternetConnectionError,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackbar(
            text: "Нет интернет соединения",
            theme: theme,
          ),
        );
      },
      builder: (context, state) {
        if (state is FreeCabinetsLoading) {
          return Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Center(
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
        } else if (state is FreeCabinetsData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: 12.r,
                    runSpacing: 12.r,
                    children: state.freeCabinets
                        .map(
                          (freeCabinet) => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: CommonChoiceButton(
                              text: freeCabinet.name,
                              onClicked: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FreeCabinetsSchedulePage(
                                      cabinetName: freeCabinet.name,
                                    ),
                                  ),
                                );
                                BlocProvider.of<FreeCabinetScheduleCubit>(
                                        context)
                                    .loadFreeCabinetSchedule(
                                  classroom: freeCabinet.name,
                                );
                              },
                              active: false,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                height: defaultTargetPlatform == TargetPlatform.android
                    ? 20.h
                    : 35.h,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
