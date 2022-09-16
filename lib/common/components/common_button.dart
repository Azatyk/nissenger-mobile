import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool reverse;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.reverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
        width: double.infinity,
        height: 56,
        child: CupertinoButton(
          color:
              reverse ? theme.colorScheme.surface : theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
          onPressed: onPressed,
          child: icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonText(
                      text: text,
                      theme: theme,
                      reverse: reverse,
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: FaIcon(
                        icon,
                        size: 13,
                        color: theme.colorScheme.surface,
                      ),
                    ),
                  ],
                )
              : ButtonText(
                  text: text,
                  theme: theme,
                  reverse: reverse,
                ),
        ));
  }
}

class ButtonText extends StatelessWidget {
  final String text;
  final ThemeData theme;
  final bool reverse;

  const ButtonText({
    Key? key,
    required this.text,
    required this.theme,
    required this.reverse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        color: !reverse ? theme.colorScheme.surface : theme.colorScheme.primary,
      ),
    );
  }
}
