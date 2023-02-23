import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/common/modals/new_preset.modal.dart';
import 'package:nissenger_mobile/modules/add_preset/data/add_preset_cubit/add_preset_cubit.dart';
import 'package:nissenger_mobile/modules/add_preset/view/components/preset_name_field.dart';

class PresetsAddPage extends StatefulWidget {
  const PresetsAddPage({Key? key}) : super(key: key);

  @override
  State<PresetsAddPage> createState() => _PresetsAddPageState();
}

class _PresetsAddPageState extends State<PresetsAddPage> {
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
                child: PresetNameField(
                  onChanged: ({required String presetName}) {
                    setState(
                      () {
                        currentPresetName = presetName;
                      },
                    );
                  },
                ),
              ),
              CommonButton(
                disabled: currentPresetName.isEmpty,
                text: "Далее",
                onPressed: () {
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
                      create: (context) => AddPresetCubit(),
                      child: NewPresetModal(
                        presetName: currentPresetName,
                      ),
                    ),
                  );
                },
                icon: FontAwesomeIcons.arrowRight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
