import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/pages/grade_choice_page.dart';
import 'package:nissenger_mobile/modules/preset_add/data/preset_add_cubit/preset_add_cubit.dart';
import 'package:nissenger_mobile/modules/preset_add/view/components/presets_name_field.dart';

class PresetsAdd extends StatefulWidget {
  const PresetsAdd({Key? key}) : super(key: key);

  @override
  State<PresetsAdd> createState() => _PresetsAddState();
}

class _PresetsAddState extends State<PresetsAdd> {
  String currentPresetName = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical:
                defaultTargetPlatform == TargetPlatform.android ? 30.h : 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonHeader(
                title: "Как назвать пресет?",
              ),
              SizedBox(height: 15.h),
              Text(
                "Назовите так, чтобы было легко понять, например, «Класс друга»",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              SizedBox(height: 25.h),
              Expanded(
                child: BlocProvider(
                  create: (context) => PresetsAddCubit(),
                  child: PresetsNameField(
                    onChanged: ({required String presetName}) {
                      setState(
                        () {
                          currentPresetName = presetName;
                        },
                      );
                    },
                  ),
                ),
              ),
              CommonButton(
                disabled: currentPresetName.isEmpty,
                text: "Далее",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const GradeChoicePage()),
                  );
                },
                icon: FontAwesomeIcons.arrowRight,
              )
            ],
          ),
        ),
      ),
    );
  }
}