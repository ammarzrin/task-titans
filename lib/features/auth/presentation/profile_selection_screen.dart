import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/features/auth/application/profile_list_provider.dart';

import 'package:tasktitans/features/auth/presentation/widgets/pin_dialog.dart';

class ProfileSelectionScreen extends ConsumerWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(familyProfilesProvider);

    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const ComicHeader(text: 'WHO ARE YOU?', fontSize: 32),
            const SizedBox(height: 40),
            Expanded(
              child: profilesAsync.when(
                data: (profiles) {
                  if (profiles == null) {
                    // No profile found -> Redirect to Onboarding
                    // using Future.microtask to avoid build-phase navigation error
                    Future.microtask(() => context.go('/onboarding/profile'));
                    return const Center(child: CircularProgressIndicator());
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.8,
                        ),
                    itemCount:
                        profiles.length + 1, // +1 for "Add Profile" button
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
                  return Center(child: Text('Error loading profiles:\n$err', textAlign: TextAlign.center));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, dynamic profile) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => PinDialog(profile: profile),
        );
      },
      child: ComicCard(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder Avatar
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.electricBlue,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              profile.username,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontFamily: 'Bungee',
                color: AppColors.comicBlack,
              ),
              textAlign: TextAlign.center,
            ),
            if (profile.role == 'parent')
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.lightningYellow,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ADMIN',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddProfileCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to Add Profile Screen
      },
      child: ComicCard(
        backgroundColor: AppColors.halftoneGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(Icons.add, size: 40, color: AppColors.comicBlack),
            ),
            const SizedBox(height: 16),
            Text(
              'ADD HERO',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontFamily: 'Bungee',
                color: AppColors.comicBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
