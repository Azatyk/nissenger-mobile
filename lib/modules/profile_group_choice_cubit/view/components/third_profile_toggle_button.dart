import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/plain_data/profile_names.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choose_cubit/profiles_choose_form_cubit/profiles_choose_form_cubit.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choose_cubit/profiles_choose_form_cubit/profiles_choose_form_state.dart';

class ThirdProfileToggleButton extends StatelessWidget {
  final Function({required int thirdProfile}) onChanged;

  const ThirdProfileToggleButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<ProfilesChooseFormCubit, ProfilesChooseFormState>(
        builder: (context, state) => Wrap(
          children: List<Widget>.generate(
            thirdProfileName.length,
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
                    thirdProfileName[index],
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14.47,
                      color: state.thirdProfile == index
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                  ),
                  selected: state.thirdProfile == index,
                  onSelected: (bool selected) {
                    if (selected) {
                      BlocProvider.of<ProfilesChooseFormCubit>(context)
                          .changeThirdProfile(thirdProfile: index);

                      onChanged(thirdProfile: index);
                    }
                  },
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
