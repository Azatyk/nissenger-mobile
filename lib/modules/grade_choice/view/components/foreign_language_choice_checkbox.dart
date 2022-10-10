import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_state.dart';

class ForeignLanguageChoiceCheckbox extends StatelessWidget {
  final Function({required bool? hasForeignLanguage}) onChanged;

  const ForeignLanguageChoiceCheckbox({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

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
              horizontal: 25.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Я хожу на уроки иностранного языка",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return theme.colorScheme.onPrimary.withOpacity(10);
                        }
                        return theme.colorScheme.onPrimary;
                      },
                    ),
                    value: state.hasForeignLanguage,
                    onChanged: (foreignLanguageValue) {
                      BlocProvider.of<GradeChoiceFormCubit>(context)
                          .changePresenceOfForeignLanguage(
                              hasForeignLanguage:
                                  foreignLanguageValue ?? false);

                      onChanged(hasForeignLanguage: foreignLanguageValue);
                    })
              ],
            ),
          ),
          onPressed: () {
            BlocProvider.of<GradeChoiceFormCubit>(context)
                .changePresenceOfForeignLanguage(
                    hasForeignLanguage: !state.hasForeignLanguage);
          },
        ),
      ),
    );
  }
}
