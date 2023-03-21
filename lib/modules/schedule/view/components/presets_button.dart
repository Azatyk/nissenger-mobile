import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/presets/view/pages/presets_page.dart';

class PresetsButton extends StatelessWidget {
  const PresetsButton({super.key});

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
          color: const Color(0xFFDF8A28),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PresetsPage(),
              ),
            );
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LangKeys.presets.translate(context),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.surface,
                    height: 1.1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "assets/icons/presets-icon.png",
                  width: 24.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
