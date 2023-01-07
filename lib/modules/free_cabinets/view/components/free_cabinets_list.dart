import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_choice_button.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/common/modals/free_cabinet.modal.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinet_schedule_cubit/free_cabinets_schedule_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_cubit/free_cabinets_list_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_cubit/free_cabinets_list_state.dart';

class FreeCabinetsList extends StatelessWidget {
  const FreeCabinetsList({
    Key? key,
  }) : super(key: key);

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
              Text(
                "Кабинеты:",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: SingleChildScrollView(
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
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.r),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) => FreeCabinetModal(
                                    cabinetName: freeCabinet.name,
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
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
