import "package:flutter/material.dart";

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary,
      child: Center(
          child: SizedBox(
        width: 70,
        height: 70,
        child: CircularProgressIndicator(
          color: theme.colorScheme.surface,
          strokeWidth: 2,
        ),
      )),
    );
  }
}
