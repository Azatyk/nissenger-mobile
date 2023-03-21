import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/pages/grade_choice_page.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/pages/teachers_choice_page.dart';
import '../../helpers/lang_keys.dart';
import '../../modules/add_preset/data/add_preset_cubit/add_preset_cubit.dart';

class NewPresetModal extends StatelessWidget {
  final String presetName;

  const NewPresetModal({
    required this.presetName,
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
            LangKeys.createNewPreset.translate(context),
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            LangKeys.presetType.translate(context),
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
                secondary: true,
                text: LangKeys.presetStudent.translate(context),
                onPressed: () {
                  BlocProvider.of<AddPresetCubit>(context).saveUserData(
                    isStudent: true,
                    presetName: presetName,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AddPresetCubit(),
                        child: const ChoicePage(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CommonButton(
                secondary: true,
                text: LangKeys.presetTeacher.translate(context),
                onPressed: () {
                  BlocProvider.of<AddPresetCubit>(context).saveUserData(
                    isStudent: false,
                    presetName: presetName,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TeachersChoicePage(),
                    ),
                  );
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

class ChoicePage extends StatelessWidget {
  const ChoicePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradeChoicePage(
      onBackButtonPressed: () {
        BlocProvider.of<AddPresetCubit>(context).clearHiveBoxes();
        Navigator.of(context).pop();
      },
    );
  }
}
