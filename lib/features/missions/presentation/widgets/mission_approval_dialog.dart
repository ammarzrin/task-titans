import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/data/repositories/mission_repository.dart';
import 'package:tasktitans/features/auth/application/profile_list_provider.dart';
import 'package:tasktitans/features/missions/application/mission_list_provider.dart';

class MissionApprovalDialog extends ConsumerStatefulWidget {
  final Mission mission;

  const MissionApprovalDialog({super.key, required this.mission});

  @override
  ConsumerState<MissionApprovalDialog> createState() => _MissionApprovalDialogState();
}

class _MissionApprovalDialogState extends ConsumerState<MissionApprovalDialog> {
  bool _isLoading = false;

  void _handleApproval(bool isApproved) async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(missionRepositoryProvider);
      if (isApproved) {
        await repo.approveMission(widget.mission.id);
      } else {
        // Re-open mission
        await repo.updateMissionStatus(widget.mission.id, MissionStatus.available);
      }
      
      ref.invalidate(missionsProvider);
      ref.invalidate(familyProfilesProvider); // Force refresh of profile stats (XP/Gold)
      
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
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
            const Text(
              'MISSION REVIEW',
              style: TextStyle(fontFamily: 'Bungee', fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              widget.mission.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Did the titan complete this mission?',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
             const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ComicButton(
                    text: 'REJECT',
                    color: AppColors.vigilanteRed,
                    onPressed: _isLoading ? null : () => _handleApproval(false),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ComicButton(
                    text: 'APPROVE',
                    color: AppColors.hulkGreen,
                    onPressed: _isLoading ? null : () => _handleApproval(true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('CANCEL', style: TextStyle(fontFamily: 'Bungee', color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
