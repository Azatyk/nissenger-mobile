import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/modals/sau_notifications.modal.dart';

class NotificationsButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool notificationEnabled;

  const NotificationsButton({
    Key? key,
    this.onPressed,
    required this.notificationEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 50.r,
      width: 50.r,
      child: CupertinoButton(
        color: notificationEnabled
            ? theme.colorScheme.onSurface
            : theme.colorScheme.background,
        padding: const EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(30.r),
        onPressed: onPressed ??
            () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  context: context,
                  builder: (context) => const SauNotificationsModal());
            },
        child: FaIcon(
          FontAwesomeIcons.solidBell,
          size: 16.sp,
          color: notificationEnabled
              ? theme.colorScheme.primary
              : theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
