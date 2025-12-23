import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_text_field.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/data/repositories/profile_repository.dart';
import 'package:tasktitans/features/auth/application/profile_list_provider.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';
import 'package:uuid/uuid.dart'; // Ensure uuid is imported

class CreateChildDialog extends ConsumerStatefulWidget {
  const CreateChildDialog({super.key});

  @override
  ConsumerState<CreateChildDialog> createState() => _CreateChildDialogState();
}

class _CreateChildDialogState extends ConsumerState<CreateChildDialog> {
  final _nameController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isLoading = false;

  void _createChild() async {
    if (_nameController.text.isEmpty || _pinController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name and 4-digit PIN.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final currentUser = ref.read(userNotifierProvider);
      if (currentUser == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error: No active parent profile selected.'),
            ),
          );
        }
        return;
      }

      final childId = const Uuid().v4();

      final childProfile = Profile(
        id: childId,
        familyId: currentUser.familyId,
        role: UserRole.child,
        username: _nameController.text.trim(),
        avatarId: 'default_child', // TODO: Add picker
        pinCode: _pinController.text.trim(),
        xp: 0,
        gold: 0,
        level: 1,
      );

      await ref.read(profileRepositoryProvider).createProfile(childProfile);

      // Refresh the list
      ref.invalidate(familyProfilesProvider);

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(width: 3),
          boxShadow: const [
            BoxShadow(color: AppColors.comicBlack, offset: Offset(8, 8)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'NEW TITAN',
              style: TextStyle(fontFamily: 'Bungee', fontSize: 24),
            ),
            const SizedBox(height: 24),
            ComicTextField(
              controller: _nameController,
              label: 'HERO NAME',
              hintText: 'Super Kid',
            ),
            const SizedBox(height: 16),
            ComicTextField(
              controller: _pinController,
              label: 'PIN CODE',
              hintText: '0000',
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ComicButton(
              text: 'RECRUIT',
              onPressed: _createChild,
              color: AppColors.hulkGreen,
            ),
            const SizedBox(height: 12),
            ComicButton(
              text: 'CANCEL',
              onPressed: () => context.pop(),
              color: AppColors.halftoneGrey,
            ),
          ],
        ),
      ),
    );
  }
}
