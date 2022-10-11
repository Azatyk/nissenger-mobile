import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_form_cubit/foreign_language_choice_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_form_cubit/foreign_language_choice_state.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/plain_data/languages.dart';

class LanguageToggleButton extends StatelessWidget {
  final Function({required int foreignLanguage}) onChanged;

  const LanguageToggleButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<ForeignLanguageFormCubit, ForeignLanguageFormState>(
        builder: (context, state) =>
            // Container(
            //   padding: const EdgeInsets.all(0),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(
            //       vertical: 20.h,
            //       horizontal: 25.w,
            //     ),
            //     child:
            Wrap(
          children: List<Widget>.generate(
            languages.length,
            (int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                child: ChoiceChip(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  backgroundColor: theme.colorScheme.background,
                  disabledColor: theme.colorScheme.onBackground,
                  selectedColor: theme.colorScheme.onPrimary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  label: Text(
                    languages[index],
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14.47,
                      color: state.foreignLanguage == index
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                  ),
                  selected: state.foreignLanguage == index,
                  onSelected: (bool selected) {
                    // setState(() {
                    //   _value = selected ? index : null;
                    // });
                    if (selected) {
                      BlocProvider.of<ForeignLanguageFormCubit>(context)
                          .changeForeignLanguage(foreignlanguage: index);

                      onChanged(foreignLanguage: index);
                    }
                  },
                ),
              );
            },
          ).toList(),
        ),
      ),
//        ),
//    ),
    );
  }
}
