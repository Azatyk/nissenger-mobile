import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/plain_data/languages.dart';

class LanguageToggleButton extends StatelessWidget {
  final Function({required String languageValue}) onChanged;

  const LanguageToggleButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String value = "";

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: [
          ...languages.map(
            (language) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                child: ChoiceChip(
                  pressElevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  backgroundColor: theme.colorScheme.background,
                  disabledColor: theme.colorScheme.onBackground,
                  selectedColor: theme.colorScheme.onPrimary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  label: Text(
                    language,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14.47,
                      color: value == language
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                  ),
                  selected: value == language,
                  onSelected: (bool selected) {
                    // setState(
                    //   () {
                    if (selected) {
                      value = language;
                      onChanged(languageValue: value);
                    }
                    // },
                    // );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
