import 'package:flutter/material.dart';

SnackBar errorSnackbar({
  required String text,
  required ThemeData theme,
}) {
  return SnackBar(
    content: Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.surface,
      ),
    ),
    backgroundColor: theme.colorScheme.error,
  );
}
