import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/data/repositories/auth_repository.dart';
import 'package:tasktitans/features/auth/application/profile_list_provider.dart';
import 'package:tasktitans/features/auth/presentation/widgets/create_child_dialog.dart';
import 'package:tasktitans/features/auth/presentation/widgets/pin_dialog.dart';

class ProfileSelectionScreen extends ConsumerWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(familyProfilesProvider);

    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: AppColors.electricBlue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Column(
          children: [
            ComicHeader(
              text: 'WELCOME TITAN',
              fontSize: 32,
              color: Colors.white,
            ),
            Text(
              'Select your profile.',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        shape: const Border(
          bottom: BorderSide(color: AppColors.comicBlack, width: 2),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: profilesAsync.when(
              data: (profiles) {
                if (profiles == null) {
                  Future.microtask(() => context.go('/onboarding/profile'));
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: profiles.length + 1,
                  itemBuilder: (context, index) {
                    if (index == profiles.length) {
                      return _buildAddProfileCard(context);
                    }
                    final profile = profiles[index];
                    return _buildProfileCard(context, profile);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) {
                debugPrint('Profile Fetch Error: $err\nStack: $stack');
                return Center(
                  child: Text(
                    'Error loading profiles:\n$err',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              color: AppColors.electricBlue,
              border: Border(
                top: BorderSide(color: AppColors.comicBlack, width: 2),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: ComicButton(
                  text: 'SIGN OUT',
                  color: AppColors.vigilanteRed,
                  onPressed: () async {
                    await ref.read(authRepositoryProvider).signOut();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, Profile profile) {
    final isParent = profile.role == UserRole.parent;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => PinDialog(profile: profile),
        );
      },
      child: ComicCard(
        backgroundColor: AppColors.pureWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: isParent
                  ? AppColors.lightningYellow
                  : AppColors.electricBlue,
              child: const Icon(Icons.person, size: 40, color: Colors.black),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Text(
                profile.username,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: 'Bungee',
                  color: AppColors.comicBlack,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isParent) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.lightningYellow,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'ADMIN',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddProfileCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const CreateChildDialog(),
        );
      },
      child: ComicCard(
        backgroundColor: AppColors.halftoneGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.pureWhite,
              child: Icon(
                Icons.add_circle,
                size: 40,
                color: AppColors.comicBlack,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'ADD TITAN',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontFamily: 'Bungee',
                color: AppColors.comicBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
