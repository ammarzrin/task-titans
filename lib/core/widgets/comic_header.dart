import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_typography.dart';

class ComicHeader extends StatelessWidget {
  final String text;
  final Color? color;

  const ComicHeader({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.h1.copyWith(
        color: color,
        // Optional: Add a text stroke if we want even more "comic" feel later
      ),
      textAlign: TextAlign.center,
    );
  }
}
