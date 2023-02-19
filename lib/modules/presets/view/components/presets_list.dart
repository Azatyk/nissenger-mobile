import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/helpers/error_messages.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_cubit.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_request_cubit/presets_request_cubit.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_request_cubit/presets_request_state.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_scroll_cubit/presets_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/presets/view/components/preset_tile.dart';

import '../../../../config/hive_boxes.dart';
import '../../data/presets_scroll_cubit/presets_scroll_state.dart';

class PresetsList extends StatefulWidget {
  const PresetsList({
    Key? key,
  }) : super(key: key);

  @override
  State<PresetsList> createState() => _PresetsListState();
}

class _PresetsListState extends State<PresetsList> with WidgetsBindingObserver {
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(scrollListener);

    BlocProvider.of<PresetsScrollCubit>(context).reachTop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToTop();
    });

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void scrollListener() {
    var currentState = context.read<PresetsScrollCubit>().state;

    if (controller.offset > controller.position.minScrollExtent &&
        !controller.position.outOfRange &&
        currentState is PresetsScrollHideBorder) {
      BlocProvider.of<PresetsScrollCubit>(context, listen: false)
          .scrollToBottom();
    } else if (controller.offset <= controller.position.minScrollExtent &&
        currentState is PresetsScrollShowBorder) {
      BlocProvider.of<PresetsScrollCubit>(context, listen: false).reachTop();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      scrollToTop();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void scrollToTop() {
    if (controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 1),
        curve: Curves.bounceInOut,
      );
    }
  }

  bool isActiveCheck(
      {required Preset? currentPreset, required Preset? activePreset}) {
    return currentPreset!.gradeNumber == activePreset!.gradeNumber &&
        currentPreset.gradeLetter == activePreset.gradeLetter &&
        listEquals(
            currentPreset.foreignLanguages, activePreset.foreignLanguages) &&
        currentPreset.firstMainProfile == activePreset.firstMainProfile &&
        currentPreset.secondMainProfile == activePreset.secondMainProfile &&
        currentPreset.thirdProfile == activePreset.thirdProfile &&
        currentPreset.firstProfileGroup == activePreset.firstProfileGroup &&
        currentPreset.secondProfileGroup == activePreset.secondProfileGroup &&
        currentPreset.thirdProfileGroup == activePreset.thirdProfileGroup &&
        currentPreset.teacherName == activePreset.teacherName &&
        currentPreset.presetName == activePreset.presetName;
  }

  List<Preset?> sortedList(
      {required List<Preset?> initialList, required Preset? activePreset}) {
    List<Preset?> list = [];

    for (var i = 0; i < initialList.length; i++) {
      if (isActiveCheck(
          currentPreset: initialList[i], activePreset: activePreset)) {
        list.insert(0, initialList[i]);
        initialList.remove(initialList[i]);
      }
    }

    if (list.isNotEmpty) {
      for (var j = 1; j < initialList.length + 1; j++) {
        list.insert(j, initialList[j - 1]);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var box = Hive.box<Preset?>(ActivePresetBox.boxName);
    Preset? presetActive;
    if (box.length >= 1) {
      presetActive = box.getAt(0);
    }

    return BlocBuilder<PresetsRequestCubit, PresetsRequestState>(
      builder: (context, state) {
        if (state is PresetsLoading) {
          return Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Center(
              child: SizedBox(
                width: 40.r,
                height: 40.r,
                child: CircularProgressIndicator(
                  strokeWidth: 6.r,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          );
        } else if (state is PresetsRequestData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<PresetsScrollCubit, PresetsScrollState>(
                builder: (context, state) => state is PresetsScrollShowBorder
                    ? const DashedDivider()
                    : SizedBox(height: 1.h),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...sortedList(
                              activePreset: presetActive,
                              initialList: state.presets)
                          .map(
                            (preset) => BlocProvider(
                              create: (context) => PresetsActiveChangeCubit(),
                              child: PresetTile(
                                onActiveChanged: () {
                                  setState(() {});
                                },
                                currentPreset: preset,
                                presetNum: state.presets.indexOf(preset) + 1,
                                isActive: isActiveCheck(
                                    currentPreset: preset,
                                    activePreset: presetActive),
                              ),
                            ),
                          )
                          .toList(),
                      SizedBox(
                        height: 30.h,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is PresetsUnknownError) {
          return ErrorBlock(
            errorType: ErrorTypes.unknownError,
            onMainButtonPressed: () =>
                BlocProvider.of<PresetsRequestCubit>(context).loadPresets(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
