import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

class PresetNameField extends StatefulWidget {
  final Function({required String presetName}) onChanged;

  const PresetNameField({
    required this.onChanged,
    super.key,
  });

  @override
  State<PresetNameField> createState() => _PresetNameFieldState();
}

class _PresetNameFieldState extends State<PresetNameField> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextFormField(
      onChanged: (value) {
        setState(
          () {
            widget.onChanged(presetName: value);
          },
        );
      },
      style: theme.textTheme.titleLarge?.copyWith(fontSize: 20.sp),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      controller: textController,
      autofocus: true,
      maxLength: 30,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: LangKeys.presetName.translate(context),
        counterText: "",
        hintStyle: theme.textTheme.titleLarge?.copyWith(
          fontSize: 20.sp,
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
