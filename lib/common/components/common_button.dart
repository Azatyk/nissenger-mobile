import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class CommonButton extends StatelessWidget {
  final String text;
  final IconData? icon;

  const CommonButton({
    Key? key,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          child: icon == null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonText(
                      text: text,
                      theme: theme,
                    ),
                    const SizedBox(width: 10),
                    FaIcon(
                      icon,
                    ),
                  ],
                )
              : ButtonText(
                  text: text,
                  theme: theme,
                ),
          onPressed: () {},
        ));
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    required this.text,
    required this.theme,
  }) : super(key: key);

  final String text;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme.textTheme.button?.copyWith(
        color: theme.colorScheme.primary,
      ),
    );
  }
}
