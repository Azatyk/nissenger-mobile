import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_cubit.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_state.dart';

import '../../../../common/cubits/support_cubit/support_cubit.dart';
import '../../../../common/modals/support.modal.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state is SplashStateInternetConnectionError ||
            state is SplashStateUnknownError) {
          return ErrorBlock(
            reverseColor: true,
            title: state is SplashStateInternetConnectionError
                ? "Нет интернета"
                : "Что-то пошло не так",
            subtitle: state is SplashStateInternetConnectionError
                ? "Проверьте подключение и попробуйте снова"
                : "Попробуйте обновить или напишите нам, мы разберемся",
            mainButtonText: "Обновить",
            onMainButtonPressed: () {
              BlocProvider.of<SplashCubit>(context).initializeApp();
            },
            secondaryButton: true,
            secondaryButtonText: "Написать нам",
            onSecondaryButtonPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                    20.r,
                  )),
                ),
                context: context,
                builder: (context) => BlocProvider(
                  create: (context) => SupportCubit(),
                  child: const SupportMethodsModal(),
                ),
              );
            },
          );
        } else if (state is SplashStateLoading) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60.r,
                height: 60.r,
                child: CircularProgressIndicator(
                  strokeWidth: 4.r,
                  color: theme.colorScheme.surface,
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "Загружаем расписание",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.surface,
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
