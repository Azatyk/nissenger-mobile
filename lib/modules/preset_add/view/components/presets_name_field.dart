import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PresetsNameField extends StatefulWidget {
  final Function({required String presetName}) onChanged;

  const PresetsNameField({
    required this.onChanged,
    super.key,
  });

  @override
  State<PresetsNameField> createState() => _PresetsNameFieldState();
}

class _PresetsNameFieldState extends State<PresetsNameField> {
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
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Название пресета",
        hintStyle: theme.textTheme.titleLarge?.copyWith(
          fontSize: 20.sp,
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
