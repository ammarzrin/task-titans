import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/data/models/profile.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';

class HeroStatsHeader extends ConsumerWidget {
  final Profile profile;

  const HeroStatsHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Logic for XP progress bar
    // Assuming Level 1 is 0-500 XP, Level 2 is 500-1000, etc. (Simplistic for now)
    final int currentXp = profile.xp ?? 0;
    final int level = profile.level ?? 1;
    final int xpInLevel = currentXp % 500;
    final double progress = xpInLevel / 500;

    return ComicCard(
      backgroundColor: AppColors.pureWhite,
      padding: const EdgeInsets.all(12),
      expand: false,
      child: Stack(
        children: [
          Row(
            children: [
              // Avatar & Level Badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.electricBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.comicBlack, width: 2),
                    ),
                    child: const Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.vigilanteRed,
                        border: Border.all(color: AppColors.comicBlack, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Lvl $level',
                        style: const TextStyle(
                          fontFamily: 'Bungee',
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Name, XP Bar, and Gold
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          profile.username.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'Bungee',
                            fontSize: 18,
                            color: AppColors.comicBlack,
                          ),
                        ),
                        _buildGoldStash(profile.gold ?? 0),
                        const SizedBox(width: 32), // Space for exit button
                      ],
                    ),
                    const SizedBox(height: 8),
                    // XP Bar Label
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ENERGY (XP)',
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
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.comicBlack, width: 2),
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
          // Exit/Logout Button
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                ref.read(userNotifierProvider.notifier).logout();
                context.go('/profile-selection');
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.halftoneGrey,
                  border: Border.all(color: AppColors.comicBlack, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.exit_to_app,
                  size: 18,
                  color: AppColors.comicBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoldStash(int gold) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightningYellow,
        border: Border.all(color: AppColors.comicBlack, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on, size: 16, color: AppColors.comicBlack),
          const SizedBox(width: 4),
          Text(
            '$gold',
            style: const TextStyle(
              fontFamily: 'Bungee',
              fontSize: 14,
              color: AppColors.comicBlack,
            ),
          ),
        ],
      ),
    );
  }
}
