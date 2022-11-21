import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/common/modals/second_schedule_page_button.modal.dart';

class FreeCabinetButton extends StatelessWidget {
  const FreeCabinetButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth - 6,
        height: 100.h,
        child: CupertinoButton(
          padding: EdgeInsets.only(
            left: 14.w,
            bottom: 16.h,
          ),
          borderRadius: BorderRadius.circular(10.r),
          color: const Color(0xFF10AC84),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                  20.r,
                )),
              ),
              context: context,
              builder: (context) => SecondSchedulePageButtonModal(
                userType: UserTypes.teacher,
              ),
            );
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Свободный\nкабинет",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.surface,
                    height: 1.1,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.7, -1.5),
                child: Image.asset(
                  "assets/icons/door-icon.png",
                  width: 48.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
