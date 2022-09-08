import "package:flutter/material.dart";

class GreetingTitle extends StatelessWidget {
  const GreetingTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Встречайте,\nваш Nissenger",
              style: theme.textTheme.displaySmall,
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            width: 30,
            child: Image.asset(
              "assets/images/image-logo.png",
            ),
          ),
        ),
      ],
    );
  }
}
