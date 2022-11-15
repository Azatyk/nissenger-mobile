import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScheduleHeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onClicked;
  final bool active;

  const ScheduleHeaderButton({
    Key? key,
    required this.icon,
    required this.onClicked,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: active ? onClicked : null,
      child: FaIcon(
        icon,
        size: 14.sp,
        color: active
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withOpacity(0.4),
      ),
    );
  }
}
