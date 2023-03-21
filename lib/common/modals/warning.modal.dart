import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import '../../modules/greeting/view/pages/greeting_page.dart';
import '../../modules/profile/data/profile_data_cubit/profile_data_cubit.dart';

class Warning extends StatelessWidget {
  const Warning({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Text(
            LangKeys.warning.translate(context),
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            LangKeys.warningDescription.translate(context),
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontSize: 15.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 30.h),
          Column(
            children: [
              CommonButton(
                danger: true,
                text: LangKeys.quit.translate(context),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const GreetingPage(),
                    ),
                    (route) => false,
                  );
                  BlocProvider.of<ProfileDataCubit>(context).logout();
                  BlocProvider.of<ProfileDataCubit>(context).setInitialData();
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CommonButton(
                secondary: true,
                text: LangKeys.cancel.translate(context),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(
            height:
                defaultTargetPlatform == TargetPlatform.android ? 35.h : 50.h,
          ),
        ],
      ),
    );
  }
}
