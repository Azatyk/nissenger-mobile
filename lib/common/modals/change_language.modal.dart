import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import '../../modules/profile/data/profile_data_cubit/profile_data_cubit.dart';
import '../../modules/schedule/view/pages/schedule_page.dart';

class ChangeLanguageModal extends StatelessWidget {
  const ChangeLanguageModal({Key? key}) : super(key: key);

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
            LangKeys.changeLangQuestion.translate(context),
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            LangKeys.changeLangDescription.translate(context),
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontSize: 15.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 45.h),
          CommonButton(
            text: LangKeys.changeLanguage.translate(context),
            onPressed: () {
              BlocProvider.of<ProfileDataCubit>(context).changeLanguage();

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SchedulePage()),
                (route) => false,
              );
            },
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
