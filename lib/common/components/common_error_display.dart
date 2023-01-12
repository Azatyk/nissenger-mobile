import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_cubit.dart';
import 'package:nissenger_mobile/common/modals/support.modal.dart';

class CommonErrorDisplay extends StatelessWidget {
  final bool isInternetConnectionError;
  final Function onPressedFunction;
  const CommonErrorDisplay({
    required this.isInternetConnectionError,
    required this.onPressedFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Center(
        child: ErrorBlock(
          title: isInternetConnectionError
              ? "Нет интернета"
              : "Что-то пошло не так",
          subtitle: isInternetConnectionError
              ? "Проверьте подключение и попробуйте снова"
              : "Попробуйте обновить или напишите нам, мы разберемся",
          mainButtonText: "Обновить",
          onMainButtonPressed: () => onPressedFunction,
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
        ),
      ),
    );
  }
}
