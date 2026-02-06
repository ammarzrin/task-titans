import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/data/models/mission.dart';

class ChildMissionCard extends StatelessWidget {
  final Mission mission;
  final VoidCallback onTap;

  const ChildMissionCard({
    super.key,
    required this.mission,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ComicCard(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Reward Banner
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(
                color: AppColors.lightningYellow,
                border: Border(
                  bottom: BorderSide(color: AppColors.comicBlack, width: 2),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Text(
                'REWARD: ${mission.goldReward} GOLD',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Bungee',
                  fontSize: 12,
                  color: AppColors.comicBlack,
                ),
              ),
            ),
            
            // Icon Section
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Icon(
                    _getIconData(mission.iconId),
                    size: 48,
                    color: AppColors.electricBlue,
                  ),
                ),
              ),
            ),

            // Title Section
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.halftoneGrey,
                border: Border(
                  top: BorderSide(color: AppColors.comicBlack, width: 2),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    mission.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Bungee',
                      fontSize: 14,
                      color: AppColors.comicBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildDifficultyStars(mission.difficulty),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyStars(MissionDifficulty difficulty) {
    int starCount = 1;
    switch (difficulty) {
      case MissionDifficulty.easy: starCount = 1; break;
      case MissionDifficulty.medium: starCount = 2; break;
      case MissionDifficulty.hard: starCount = 3; break;
      case MissionDifficulty.epic: starCount = 4; break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Icon(
          index < starCount ? Icons.star : Icons.star_border,
          size: 14,
          color: AppColors.vigilanteRed,
        );
      }),
    );
  }

  IconData _getIconData(String iconId) {
    // Basic mapping for now
    switch (iconId) {
      case 'broom': return Icons.cleaning_services;
      case 'bed': return Icons.bed;
      case 'trash': return Icons.delete;
      default: return Icons.rocket_launch;
    }
  }
}
