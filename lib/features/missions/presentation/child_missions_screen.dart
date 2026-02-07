import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/data/repositories/mission_repository.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';
import 'package:tasktitans/features/missions/application/mission_list_provider.dart';

class ChildMissionsScreen extends ConsumerWidget {
  const ChildMissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProfile = ref.watch(userNotifierProvider);
    final missionsAsync = ref.watch(missionsProvider);

    if (activeProfile == null) {
      return const Scaffold(body: Center(child: Text('No Profile Selected')));
    }

    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.electricBlue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Column(
          children: [
            ComicHeader(
              text: 'MY MISSIONS',
              fontSize: 24,
              color: Colors.white,
            ),
            Text(
              'Active Quests',
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
      body: missionsAsync.when(
        data: (missions) {
          // Filter missions assigned to this child and in progress
          final myMissions = missions.where((m) {
            return m.assignedTo == activeProfile.id &&
                m.status == MissionStatus.inProgress;
          }).toList();

          if (myMissions.isEmpty) {
            return const Center(
              child: Text(
                'NO ACTIVE MISSIONS!',
                style: TextStyle(fontFamily: 'Bungee', fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: myMissions.length,
            itemBuilder: (context, index) {
              final mission = myMissions[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ComicCard(
                  expand: false,
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(mission.difficulty),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 2),
                        ),
                        child: Icon(
                          _getDifficultyIcon(mission.difficulty),
                          color: mission.difficulty == MissionDifficulty.medium
                              ? AppColors.comicBlack
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Title & Rewards
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mission.title,
                              style: const TextStyle(
                                fontFamily: 'Bungee',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${mission.xpReward} XP | ${mission.goldReward} Gold',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Mark as Done Button
                      SizedBox(
                        width: 100,
                        child: ComicButton(
                          text: 'DONE',
                          fontSize: 12,
                          height: 40,
                          color: AppColors.hulkGreen,
                          onPressed: () async {
                            await ref
                                .read(missionRepositoryProvider)
                                .completeMission(mission.id);
                            ref.invalidate(missionsProvider);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Color _getDifficultyColor(MissionDifficulty difficulty) {
    switch (difficulty) {
      case MissionDifficulty.easy:
        return AppColors.electricBlue;
      case MissionDifficulty.medium:
        return AppColors.lightningYellow;
      case MissionDifficulty.hard:
        return AppColors.vigilanteRed;
      case MissionDifficulty.epic:
        return AppColors.epicPurple; // Assuming you added this
    }
  }

  IconData _getDifficultyIcon(MissionDifficulty difficulty) {
    switch (difficulty) {
      case MissionDifficulty.easy:
        return Icons.star_outline;
      case MissionDifficulty.medium:
        return Icons.star_half;
      case MissionDifficulty.hard:
        return Icons.star;
      case MissionDifficulty.epic:
        return Icons.auto_awesome;
    }
  }
}
