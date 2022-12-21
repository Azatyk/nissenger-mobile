import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      width: double.infinity,
      height: 1.h,
      color: theme.colorScheme.onBackground.withOpacity(0.7),
    );
    // return LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) {
    //     final boxWidth = constraints.constrainWidth();
    //     const dashWidth = 20.0;
    //     const dashHeight = 1.0;
    //     final dashCount = (boxWidth / (1.5 * dashWidth)).floor();
    //     return Flex(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       direction: Axis.horizontal,
    //       children: List.generate(dashCount, (_) {
    //         return const SizedBox(
    //           width: dashWidth,
    //           height: dashHeight,
    //           child: DecoratedBox(
    //             decoration: BoxDecoration(color: Color(0xFFCACACA)),
    //           ),
    //         );
    //       }),
    //     );
    //   },
    // );
  }
}
