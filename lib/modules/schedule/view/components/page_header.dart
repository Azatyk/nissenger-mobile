import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:nissenger_mobile/modules/profile/view/pages/profile_page.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Nissenger",
          style: theme.textTheme.displaySmall?.copyWith(
            fontSize: 23.sp,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(
          width: 44.r,
          height: 44.r,
          child: Center(
            child: CupertinoButton(
              color: theme.colorScheme.onSurface,
              padding: const EdgeInsets.all(0),
              borderRadius: BorderRadius.circular(30.r),
              child: Align(
                child: Image.asset(
                  "assets/icons/user-icon.png",
                  width: 14.w,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
