import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/theme/app_typography.dart';

class ComicTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const ComicTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.caption.copyWith(color: AppColors.comicBlack),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: AppColors.comicBlack,
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.comicBlack),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTypography.bodyMedium.copyWith(color: Colors.grey),
              filled: true,
              fillColor: AppColors.pureWhite,
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.comicBlack)
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.comicBlack, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.electricBlue, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
