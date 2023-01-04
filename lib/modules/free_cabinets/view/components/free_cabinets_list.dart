import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_choice_button.dart';
import 'package:nissenger_mobile/common/modals/free_cabinet_modal.dart';
import 'package:nissenger_mobile/data/models/free_cabinet.model.dart';

class FreeCabinetsList extends StatelessWidget {
  final List<FreeCabinet> freeCabinets;

  const FreeCabinetsList({
    Key? key,
    required this.freeCabinets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String activeCabinet = "";
    ThemeData theme = Theme.of(context);

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
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: freeCabinets
              .map(
                (freeCabinet) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CommonChoiceButton(
                    text: freeCabinet.cabinet.name,
                    onClicked: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                            20.r,
                          )),
                        ),
                        context: context,
                        builder: (context) => FreeCabinetModal(
                          cabinetName: freeCabinet.cabinet.name,
                          isFree: freeCabinet.isFree,
                          lessonsLeft: freeCabinet.lessonsLeft,
                        ),
                      );
                      if (activeCabinet != freeCabinet.cabinet.name) {
                        activeCabinet = freeCabinet.cabinet.name;
                      }
                    },
                    active: freeCabinet.cabinet.name == activeCabinet,
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
