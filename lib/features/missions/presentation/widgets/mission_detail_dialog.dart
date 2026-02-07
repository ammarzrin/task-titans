import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/data/repositories/mission_repository.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';
import 'package:tasktitans/features/missions/application/mission_list_provider.dart';

class MissionDetailDialog extends ConsumerStatefulWidget {
  final Mission mission;

  const MissionDetailDialog({super.key, required this.mission});

  @override
  ConsumerState<MissionDetailDialog> createState() =>
      _MissionDetailDialogState();
}

class _MissionDetailDialogState extends ConsumerState<MissionDetailDialog> {
  bool _isLoading = false;

  Future<void> _handleAction() async {
    final activeProfile = ref.read(userNotifierProvider);
    if (activeProfile == null) return;

    setState(() => _isLoading = true);
    try {
      final repo = ref.read(missionRepositoryProvider);

      if (widget.mission.status == MissionStatus.available) {
        // CLAIM
        await repo.claimMission(widget.mission.id, activeProfile.id);
      } else if (widget.mission.status == MissionStatus.inProgress) {
        // COMPLETE
        await repo.completeMission(widget.mission.id);
      }

      ref.invalidate(missionsProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.vigilanteRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isClaiming = widget.mission.status == MissionStatus.available;

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
            // Icon & Reward
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.electricBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.rocket_launch,
                size: 64,
                color: AppColors.electricBlue,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              widget.mission.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Bungee', fontSize: 22),
            ),
            const SizedBox(height: 16),

            // Rewards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRewardPill(
                  '${widget.mission.goldReward} GOLD',
                  AppColors.lightningYellow,
                ),
                const SizedBox(width: 8),
                _buildRewardPill(
                  '${widget.mission.xpReward} XP',
                  AppColors.hulkGreen,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Action Button
            ComicButton(
              text: _isLoading
                  ? 'WORKING...'
                  : (isClaiming ? 'CLAIM MISSION!' : 'MARK AS DONE!'),
              color: isClaiming ? AppColors.electricBlue : AppColors.hulkGreen,
              onPressed: _isLoading ? null : _handleAction,
            ),
            const SizedBox(height: 12),

            // Cancel Button
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'NOT NOW',
                style: TextStyle(fontFamily: 'Bungee', color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardPill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'Bungee', fontSize: 12),
      ),
    );
  }
}
