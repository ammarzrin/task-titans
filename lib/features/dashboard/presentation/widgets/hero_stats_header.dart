import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';

class HeroStatsHeader extends ConsumerWidget {
  final Profile profile;

  const HeroStatsHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Logic for XP progress bar
    final int currentXp = profile.xp ?? 0;
    final int level = profile.level ?? 1;
    final int xpInLevel = currentXp % 500;
    final double progress = xpInLevel / 500;

    return ComicCard(
      backgroundColor: AppColors.pureWhite,
      padding: const EdgeInsets.all(16),
      expand: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Hero Name
          Row(
            children: [
              Center(
                child: Text(
                  profile.username.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Bungee',
                    fontSize: 24,
                    color: AppColors.comicBlack,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Level Indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.electricBlue,
                  border: Border.all(color: AppColors.comicBlack, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'LVL. $level',
                  style: const TextStyle(
                    fontFamily: 'Bungee',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Row 2: Avatar and Progress Column
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.electricBlue,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.comicBlack, width: 2),
                ),
                child: const Icon(Icons.person, size: 35, color: Colors.white),
              ),
              const SizedBox(width: 16),
              // Level & XP Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // XP Progress Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'XP PROGRESS',
                          style: TextStyle(
                            fontFamily: 'Bungee',
                            fontSize: 10,
                            color: AppColors.midnightGrey,
                          ),
                        ),
                        Text(
                          '$xpInLevel / 500',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // XP Bar
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.comicBlack,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.transparent,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.hulkGreen,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Row 3: Gold and Exit (Balanced)
          Row(
            children: [
              Expanded(child: _buildGoldStash(profile.gold ?? 0)),
              const SizedBox(width: 12),
              Expanded(child: _buildLogoutButton(context, ref)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoldStash(int gold) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.lightningYellow,
        border: Border.all(color: AppColors.comicBlack, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.monetization_on,
            size: 18,
            color: AppColors.comicBlack,
          ),
          const SizedBox(width: 6),
          Text(
            '$gold',
            style: const TextStyle(
              fontFamily: 'Bungee',
              fontSize: 16,
              color: AppColors.comicBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(userNotifierProvider.notifier).logout();
        context.go('/profile-selection');
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.vigilanteRed,
          border: Border.all(color: AppColors.comicBlack, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 18, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'EXIT',
              style: TextStyle(
                fontFamily: 'Bungee',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
