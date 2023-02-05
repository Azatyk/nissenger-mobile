import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_cubit.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_state.dart';

class PresetTile extends StatefulWidget {
  final String presetName;
  final int presetNum;
  final String gradeNumber;
  final String gradeLetter;
  final String group;
  final String firstProfileName;
  final String secondProfileName;
  final String thirdProfileName;
  final String firstProfileGroup;
  final String secondProfileGroup;
  final String thirdProfileGroup;
  final List<String> foreignLanguage;
  final String teacherName;

  const PresetTile({
    required this.presetName,
    required this.presetNum,
    required this.gradeNumber,
    required this.gradeLetter,
    required this.group,
    required this.firstProfileName,
    required this.secondProfileName,
    required this.thirdProfileName,
    required this.firstProfileGroup,
    required this.secondProfileGroup,
    required this.thirdProfileGroup,
    required this.foreignLanguage,
    required this.teacherName,
    super.key,
  });

  @override
  State<PresetTile> createState() => _PresetTileState();
}

class _PresetTileState extends State<PresetTile> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final String descriptionTextFirstProfile = widget
                .firstProfileName.isNotEmpty ||
            widget.firstProfileGroup.isNotEmpty
        ? "${widget.firstProfileName}${widget.firstProfileName.isEmpty ? "" : ": "}${widget.firstProfileGroup}"
        : "";

    final String descriptionTextSecondProfile =
        widget.secondProfileName.isNotEmpty ||
                widget.secondProfileGroup.isNotEmpty
            ? ", ${widget.secondProfileName}: ${widget.secondProfileGroup}"
            : "";

    final String descriptionTextThirdProfile = widget
                .thirdProfileName.isNotEmpty ||
            widget.thirdProfileGroup.isNotEmpty
        ? ", ${widget.thirdProfileName}${widget.thirdProfileGroup.isEmpty ? "" : ": "}${widget.thirdProfileGroup}"
        : "";

    final String descriptionTextForeignLanguage =
        widget.foreignLanguage.isNotEmpty
            ? ", ${widget.foreignLanguage.join(", ")},"
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
                color: Colors
                    .transparent // on condition --> theme.colorScheme.primary
                ),
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
                      widget.presetName.isEmpty
                          ? "Пресет ${widget.presetNum + 1}"
                          : widget.presetName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      widget.teacherName.isEmpty
                          ? "${widget.gradeNumber + widget.gradeLetter} класс, ${widget.group} группа"
                          : widget.teacherName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 7.5.h,
                    ),
                    widget.teacherName.isEmpty
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
                backgroundColor: theme.colorScheme
                    .onSecondary, // on condition --> theme.colorScheme.primary,
                child: CircleAvatar(
                  radius: 8.r, // on condition --> 12.r
                  backgroundColor: theme.colorScheme.background,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // BlocProvider.of<PresetsActiveChangeCubit>(context)
          //     .changeActive(gradeNumber: widget.grade);
        },
      ),
    );
  }
}
