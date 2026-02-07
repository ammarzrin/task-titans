import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/data/repositories/auth_repository.dart';
import 'package:tasktitans/features/auth/application/profile_list_provider.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';
import 'package:tasktitans/features/auth/presentation/widgets/create_child_dialog.dart';
import 'package:tasktitans/features/auth/presentation/widgets/pin_dialog.dart';

class ParentProfilesScreen extends ConsumerWidget {
  const ParentProfilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(familyProfilesProvider);
    final currentUser = ref.watch(userNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.electricBlue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Column(
          children: [
            ComicHeader(text: 'MY FAMILY', fontSize: 24, color: Colors.white),
            Text(
              'Manage your Titans',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
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
                final list = profiles ?? [];
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: list.length + 1,
                  itemBuilder: (context, index) {
                    if (index == list.length) {
                      return _buildAddButton(context);
                    }
                    final profile = list[index];
                    final isMe = profile.id == currentUser?.id;
                    return _buildProfileCard(context, profile, isMe);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
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
                  text: 'LOGOUT FAMILY',
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

  Widget _buildProfileCard(BuildContext context, Profile profile, bool isMe) {
    return GestureDetector(
      onTap: () {
        if (!isMe) {
          showDialog(
            context: context,
            builder: (context) => PinDialog(profile: profile),
          );
        }
      },
      child: ComicCard(
        backgroundColor: isMe ? AppColors.electricBlue : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: isMe ? Colors.white : AppColors.electricBlue,
              child: Icon(
                Icons.person,
                size: 35,
                color: isMe ? AppColors.electricBlue : Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              profile.username,
              style: TextStyle(
                fontFamily: 'Bungee',
                color: isMe ? Colors.white : AppColors.comicBlack,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            if (isMe)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.lightningYellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
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
            const Icon(Icons.add_circle, size: 50, color: AppColors.comicBlack),
            const SizedBox(height: 8),
            const Text(
              'ADD TITAN',
              style: TextStyle(fontFamily: 'Bungee', fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
