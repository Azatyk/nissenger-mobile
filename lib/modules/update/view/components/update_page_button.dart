import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/update/data/update_cubit/update_cubit.dart';

class UpdatePageButton extends StatelessWidget {
  const UpdatePageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAndroid = Theme.of(context).platform == TargetPlatform.android;

    return CommonButton(
      text: "Обновиться",
      reverse: true,
      onPressed: () {
        BlocProvider.of<UpdateCubit>(context)
            .navigateToMarket(isAndroid: isAndroid);
      },
    );
  }
}
