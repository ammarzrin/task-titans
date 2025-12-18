import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_colors.dart';

class ComicCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;

  const ComicCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.pureWhite,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 16.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double offset = 4.0;

    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.comicBlack, width: 2),
      ),
      padding: padding,
      child: child,
    );

    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardContent,
      );
    }

    return Stack(
      children: [
        // Shadow
        Positioned(
          top: offset,
          left: offset,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.comicBlack,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.only(right: offset, bottom: offset),
          child: cardContent,
        ),
      ],
    );
  }
}
