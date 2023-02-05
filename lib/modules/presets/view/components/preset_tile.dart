import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_cubit.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_state.dart';

import '../../../../config/preset_hive_class.dart';

class PresetTile extends StatefulWidget {
  final Function() onActiveChanged;
  final Preset? currentPreset;
  final int presetNum;
  final bool isActive;

  const PresetTile({
    required this.onActiveChanged,
    required this.currentPreset,
    required this.presetNum,
    required this.isActive,
    super.key,
  });

  @override
  State<PresetTile> createState() => _PresetTileState();
}

class _PresetTileState extends State<PresetTile> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final String descriptionTextFirstProfile = widget
                .currentPreset!.firstMainProfile.isNotEmpty ||
            widget.currentPreset!.firstProfileGroup.isNotEmpty
        ? "${widget.currentPreset!.firstMainProfile}${widget.currentPreset!.firstMainProfile.isEmpty ? "" : ": "}${widget.currentPreset!.firstProfileGroup}"
        : "";

    final String descriptionTextSecondProfile = widget
                .currentPreset!.secondMainProfile.isNotEmpty ||
            widget.currentPreset!.secondProfileGroup.isNotEmpty
        ? ", ${widget.currentPreset!.secondMainProfile}: ${widget.currentPreset!.secondProfileGroup}"
        : "";

    final String descriptionTextThirdProfile = widget
                .currentPreset!.thirdProfile.isNotEmpty ||
            widget.currentPreset!.thirdProfileGroup.isNotEmpty
        ? ", ${widget.currentPreset!.thirdProfile}${widget.currentPreset!.thirdProfileGroup.isEmpty ? "" : ": "}${widget.currentPreset!.thirdProfileGroup}"
        : "";

    final String descriptionTextForeignLanguage =
        widget.currentPreset!.foreignLanguages.isNotEmpty
            ? ", ${widget.currentPreset!.foreignLanguages.join(", ")},"
            : "";

    final String descriptionText = descriptionTextFirstProfile +
        descriptionTextSecondProfile +
        descriptionTextThirdProfile +
        descriptionTextForeignLanguage;

    return BlocBuilder<PresetsActiveChangeCubit, PresetActiveChangeState>(
      builder: (context, state) => GestureDetector(
        child: Container(
          margin: EdgeInsets.only(bottom: 15.h),
          padding:
              EdgeInsets.only(bottom: 15.h, top: 15.h, left: 15.w, right: 20.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
                width: 2.w,
                color: widget.isActive
                    ? theme.colorScheme.primary
                    : Colors.transparent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 240.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currentPreset!.presetName.isEmpty
                          ? "Пресет ${widget.presetNum + 1}"
                          : widget.currentPreset!.presetName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      widget.currentPreset!.teacherName.isEmpty
                          ? "${widget.currentPreset!.gradeNumber.toString() + widget.currentPreset!.gradeLetter} класс, ${widget.currentPreset!.gradeGroup} группа"
                          : widget.currentPreset!.teacherName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 7.5.h,
                    ),
                    widget.currentPreset!.teacherName.isEmpty
                        ? descriptionText.isNotEmpty
                            ? Text(
                                descriptionText,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: 14.sp,
                                  color: theme.colorScheme.onSecondary,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : Container()
                        : Text(
                            "Расписание учителя",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 14.sp,
                              color: theme.colorScheme.onSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                  ],
                ),
              ),
              CircleAvatar(
                radius: 12.r,
                backgroundColor: widget.isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSecondary,
                child: CircleAvatar(
                  radius: widget.isActive ? 7.r : 8.r,
                  backgroundColor: theme.colorScheme.background,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            BlocProvider.of<PresetsActiveChangeCubit>(context)
                .changeActive(presetValue: widget.currentPreset);

            widget.onActiveChanged();
          });
        },
      ),
    );
  }
}
