// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_cubit.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_state.dart';

class PresetTile extends StatefulWidget {
  final String presetName;
  String grade;
  String group;
  String firstProfileName;
  String secondProfileName;
  String thirdProfileName;
  String firstProfileGroup;
  String secondProfileGroup;
  String thirdProfileGroup;
  String foreignLanguage;
  String teacherName;

  PresetTile({
    required this.presetName,
    this.grade = "",
    this.group = "",
    this.firstProfileName = "",
    this.secondProfileName = "",
    this.thirdProfileName = "",
    this.firstProfileGroup = "",
    this.secondProfileGroup = "",
    this.thirdProfileGroup = "",
    this.foreignLanguage = "",
    this.teacherName = "",
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
        "${widget.firstProfileName}: ${widget.firstProfileGroup}, ${widget.secondProfileName}: ${widget.secondProfileGroup}, ${widget.thirdProfileName}: ${widget.thirdProfileGroup}, ${widget.foreignLanguage}";

    return BlocBuilder<PresetsActiveChangeCubit, PresetsActiveChangeState>(
      builder: (context, state) => CupertinoButton(
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
                color: Colors
                    .transparent // on condition --> theme.colorScheme.primary
                ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 190.w,
                child: Column(
                  children: [
                    Text(
                      widget.presetName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      widget.teacherName.isEmpty
                          ? "${widget.grade} класс, ${widget.group} группа"
                          : widget.teacherName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      widget.teacherName.isEmpty
                          ? descriptionText
                          : "Расписание учителя",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 20.r,
                backgroundColor: theme.colorScheme
                    .onSecondary, // on condition --> theme.colorScheme.primary,
                child: CircleAvatar(
                  radius: 14.r, // on condition --> 12.r
                  backgroundColor: theme.colorScheme.background,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
