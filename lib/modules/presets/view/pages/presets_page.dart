import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/add_preset/view/pages/presets_add_page.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_request_cubit/presets_request_cubit.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_scroll_cubit/presets_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/presets/view/components/presets_list.dart';

class PresetsPage extends StatefulWidget {
  const PresetsPage({Key? key}) : super(key: key);

  @override
  State<PresetsPage> createState() => _PresetsPageState();
}

class _PresetsPageState extends State<PresetsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) => PresetsRequestCubit(),
      child: Scaffold(
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
                  title: "Пресеты",
                ),
                SizedBox(height: 15.h),
                Text(
                  "Добавляйте классы и учителей, расписание которых вам нужно",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 25.h),
                BlocProvider(
                  create: (context) => PresetsScrollCubit(),
                  child: const Expanded(
                    child: PresetsList(),
                  ),
                ),
                CommonButton(
                  text: "Добавить пресет",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PresetsAddPage(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
