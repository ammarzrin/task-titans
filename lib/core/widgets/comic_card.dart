import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_colors.dart';

class ComicCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;
  /// Whether the card should expand to fill its parent. 
  /// Set to false when used in a ListView or other unbounded height parent.
  final bool expand;

  const ComicCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.pureWhite,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 16.0,
    this.onTap,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    const double offset = 4.0;

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
        Container(
          margin: const EdgeInsets.only(right: offset, bottom: offset),
          width: expand ? double.infinity : null,
          height: expand ? double.infinity : null,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: AppColors.comicBlack, width: 2),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}