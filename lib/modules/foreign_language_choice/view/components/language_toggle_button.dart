import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/plain_data/languages.dart';

class LanguageToggleButton extends StatefulWidget {
  final Function({required String languageValue}) onChanged;

  const LanguageToggleButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<LanguageToggleButton> createState() => _LanguageToggleButtonState();
}

class _LanguageToggleButtonState extends State<LanguageToggleButton> {
  String activeLanguage = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            ...languages.map(
              (language) {
                return CupertinoButton(
                    padding:
                        EdgeInsets.only(right: 18.w, bottom: 15.h),
                    onPressed: (() {
                      setState(() {
                        // if (activeLanguage == language) {
                        activeLanguage = language;
                        widget.onChanged(languageValue: activeLanguage);
                        // }
                      });
                    }),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: activeLanguage == language
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.background,
                      ),
                      child: Text(
                        language,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontSize: 14.47,
                          color: activeLanguage == language
                              ? theme.colorScheme.primary
                              : theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  );
      
                  // ChoiceChip(
                  //   pressElevation: 0,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10.r)),
                  //   backgroundColor: theme.colorScheme.background,
                  //   disabledColor: theme.colorScheme.onBackground,
                  //   selectedColor: theme.colorScheme.onPrimary,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  //   label: Text(
                  //     language,
                  //     style: theme.textTheme.titleSmall?.copyWith(
                  //       fontSize: 14.47,
                  //       color: activeLanguage == language
                  //           ? theme.colorScheme.primary
                  //           : theme.colorScheme.secondary,
                  //     ),
                  //   ),
                  //   selected: activeLanguage == language,
                  //   onSelected: (bool selected) {
                  //     setState(
                  //       () {
                  //         if (selected) {
                  //           activeLanguage = language;
                  //           widget.onChanged(languageValue: activeLanguage);
                  //         }
                  //       },
                  //     );
                  //   },
                  // ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
