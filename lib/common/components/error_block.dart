import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_rounded_button.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_cubit.dart';
import 'package:nissenger_mobile/common/modals/support.modal.dart';
import 'package:nissenger_mobile/helpers/error_messages.dart';

class ErrorBlock extends StatelessWidget {
  final ErrorTypes errorType;
  final VoidCallback onMainButtonPressed;
  final bool secondaryButton;

  const ErrorBlock({
    Key? key,
    required this.errorType,
    required this.onMainButtonPressed,
    this.secondaryButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // if (errorType == ErrorTypes.internetConnectionError)
            //   // Padding(
            //   //   padding: EdgeInsets.only(bottom: 35.h),
            //   //   child: Align(
            //   //     child: Image.asset(
            //   //       "assets/images/wifi-off-icon.png",
            //   //       width: 50.w,
            //   //     ),
            //   //   ),
            //   // ),
            SizedBox(
              width: 0.7.sw,
              child: Text(
                errorMessages[errorType]![ErrorMessageType.title]!,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            SizedBox(
              width: 0.8.sw,
              child: Text(
                errorMessages[errorType]![ErrorMessageType.subtitle]!,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 15.sp,
                  height: 1.45,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            CommonRoundedButton(
              text: errorMessages[errorType]![ErrorMessageType.mainButtonText]!,
              onPressed: onMainButtonPressed,
            ),
            if (secondaryButton)
              Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: CommonRoundedButton(
                  reverseColor: true,
                  text: errorMessages[errorType]![
                      ErrorMessageType.secondaryButtonText]!,
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.r)),
                      ),
                      context: context,
                      builder: (context) => BlocProvider(
                        create: (context) => SupportCubit(),
                        child: const SupportMethodsModal(),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
