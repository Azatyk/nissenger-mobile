import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_cubit.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_state.dart';

class PresetTile extends StatefulWidget {
  final String presetName;
  final String grade;
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
    required this.grade,
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

    final String descriptionText =
        "${widget.firstProfileName}: ${widget.firstProfileGroup}, ${widget.secondProfileName}: ${widget.secondProfileGroup}, ${widget.thirdProfileName}: ${widget.thirdProfileGroup}, ${widget.foreignLanguage.join(", ")}";

    return BlocBuilder<PresetsActiveChangeCubit, PresetsActiveChangeState>(
      builder: (context, state) => Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(20.r),
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
                    widget.presetName == ""
                        ? "Мое расписание"
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
                        ? "${widget.grade} класс, ${widget.group} группа"
                        : widget.teacherName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 7.5.h,
                  ),
                  Text(
                    widget.teacherName.isEmpty
                        ? descriptionText
                        : "Расписание учителя",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 14.sp,
                      color: theme.colorScheme.onSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 10.r,
              backgroundColor: theme.colorScheme
                  .onSecondary, // on condition --> theme.colorScheme.primary,
              child: CircleAvatar(
                radius: 7.r, // on condition --> 12.r
                backgroundColor: theme.colorScheme.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
