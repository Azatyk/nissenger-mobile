import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/common/modals/second_schedule_page_button.modal.dart';

class EventsButton extends StatelessWidget {
  const EventsButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth - 6,
        height: 46.h,
        child: CupertinoButton(
          padding: EdgeInsets.all(12.r),
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
                userType: UserTypes.student,
              ),
            );
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Соры (скоро)",
                  overflow: TextOverflow.fade,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.surface,
                    height: 1.1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "assets/icons/calendar-icon.png",
                  width: 23.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
