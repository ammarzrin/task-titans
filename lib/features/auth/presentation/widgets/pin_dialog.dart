import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';

class PinDialog extends ConsumerStatefulWidget {
  final Profile profile;

  const PinDialog({super.key, required this.profile});

  @override
  ConsumerState<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends ConsumerState<PinDialog> {
  final _pinController = TextEditingController();
  bool _isError = false;

  void _verifyPin(String pin) {
    if (pin == widget.profile.pinCode) {
      // Success!
      ref.read(userNotifierProvider.notifier).selectProfile(widget.profile);
      context.pop(); // Close dialog
      
      // Navigate based on role
      if (widget.profile.role == UserRole.parent) {
        context.go('/parent/dashboard');
      } else {
        context.go('/child/dashboard');
      }
    } else {
      // Failure
      setState(() {
        _isError = true;
        _pinController.clear();
      });
      // Shake animation could go here
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.comicBlack,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.comicBlack, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.comicBlack,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
    );

    final errorPinTheme = defaultPinTheme.copyBorderWith(
      border: Border.all(color: AppColors.vigilanteRed, width: 2),
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(width: 3),
          boxShadow: const [
            BoxShadow(
              color: AppColors.comicBlack,
              offset: Offset(8, 8),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SECRET IDENTITY',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: 'Bungee',
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter PIN for ${widget.profile.username}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Pinput(
              controller: _pinController,
              length: 4,
              defaultPinTheme: defaultPinTheme,
              errorPinTheme: errorPinTheme,
              obscureText: true,
              forceErrorState: _isError,
              onCompleted: _verifyPin,
              onChanged: (_) => setState(() => _isError = false),
              autofocus: true,
            ),
            if (_isError) ...[
              const SizedBox(height: 16),
              const Text(
                'INCORRECT PIN!',
                style: TextStyle(
                  color: AppColors.vigilanteRed,
                  fontFamily: 'Bungee',
                ),
              ),
            ],
            const SizedBox(height: 24),
            ComicButton(
              text: 'CANCEL',
              color: AppColors.halftoneGrey,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
