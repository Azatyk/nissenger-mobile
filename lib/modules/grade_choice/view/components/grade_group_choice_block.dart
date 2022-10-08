import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_state.dart';

class GradeGroupChoiceBlock extends StatelessWidget {
  const GradeGroupChoiceBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
        width: double.infinity,
        child: BlocBuilder<GradeChoiceFormCubit, GradeChoiceFormState>(
            builder: (context, state) => CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 28.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GroupTitle(
                          text: "1 группа",
                          theme: theme,
                          active: state.group == 1,
                        ),
                        CupertinoSwitch(
                          activeColor: theme.colorScheme.onPrimary,
                          trackColor: theme.colorScheme.onPrimary,
                          thumbColor: theme.colorScheme.primary,
                          value: state.group == 1 ? false : true,
                          onChanged: (bool value) {
                            BlocProvider.of<GradeChoiceFormCubit>(context)
                                .changeGradeGroup(group: value ? 2 : 1);
                          },
                        ),
                        GroupTitle(
                          text: "2 группа",
                          theme: theme,
                          active: state.group == 2,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<GradeChoiceFormCubit>(context)
                        .changeGradeGroup(group: state.group == 1 ? 2 : 1);
                  },
                )));
  }
}

class GroupTitle extends StatelessWidget {
  final ThemeData theme;
  final String text;
  final bool active;

  const GroupTitle({
    Key? key,
    required this.theme,
    required this.text,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        color: active ? theme.colorScheme.primary : theme.colorScheme.secondary,
      ),
    );
  }
}
