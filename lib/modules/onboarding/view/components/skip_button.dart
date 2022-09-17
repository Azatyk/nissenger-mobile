import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CupertinoButton(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 18,
      ),
      color: Colors.transparent,
      child: Text(
        "Пропустить",
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
      onPressed: () {
        // todo: navigate to next page
      },
    );
  }
}
