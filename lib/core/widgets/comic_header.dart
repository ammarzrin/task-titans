import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_typography.dart';

class ComicHeader extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;

  const ComicHeader({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.h1.copyWith(
        color: color,
        fontSize: fontSize,
        // Optional: Add a text stroke if we want even more "comic" feel later
      ),
      textAlign: TextAlign.center,
    );
  }
}
