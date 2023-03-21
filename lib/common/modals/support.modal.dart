import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_cubit.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_state.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

class SupportMethodsModal extends StatelessWidget {
  const SupportMethodsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocListener<SupportCubit, SupportState>(
      listener: (context, state) {
        if (state is SupportInternetConnectionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackbar(
              text: LangKeys.noInternetConnection.translate(context),
              theme: theme,
            ),
          );
        } else if (state is SupportUnknownError) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackbar(
              text: LangKeys.unknownError.translate(context),
              theme: theme,
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              LangKeys.contactUs.translate(context),
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 16.h),
            Text(
              LangKeys.contactDescription.translate(context),
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSecondary,
                fontSize: 15.sp,
                height: 1.6,
              ),
            ),
            SizedBox(height: 45.h),
            CommonButton(
              text: LangKeys.telegram.translate(context),
              onPressed: () {
                BlocProvider.of<SupportCubit>(context).navigateToTelegram();
              },
            ),
            SizedBox(
              height:
                  defaultTargetPlatform == TargetPlatform.android ? 35.h : 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
