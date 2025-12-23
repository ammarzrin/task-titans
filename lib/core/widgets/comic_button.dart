import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/theme/app_typography.dart';

class ComicButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;
  final double height;
  final double fontSize;
  final IconData? icon;

  const ComicButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.electricBlue,
    this.textColor = AppColors.pureWhite,
    this.height = 56.0,
    this.fontSize = 16.0,
    this.icon,
  });

  @override
  State<ComicButton> createState() => _ComicButtonState();
}

class _ComicButtonState extends State<ComicButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double offset = _isPressed ? 0 : 4.0;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.height,
        transform: Matrix4.translationValues(0, _isPressed ? 4.0 : 0, 0),
        child: Stack(
          children: [
            // Shadow Layer
            Positioned(
              top: offset,
              left: offset,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.comicBlack,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            // Button Layer
            Positioned(
              top: 0,
              left: 0,
              right: offset,
              bottom: offset,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.onPressed == null ? Colors.grey : widget.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.comicBlack, width: 2),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: widget.textColor, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text.toUpperCase(),
                      style: AppTypography.button.copyWith(
                        color: widget.textColor,
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
