import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/data/repositories/mission_repository.dart';
import 'package:tasktitans/features/auth/application/profile_by_id_provider.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';
import 'package:tasktitans/features/missions/application/mission_list_provider.dart';
import 'package:tasktitans/features/missions/presentation/widgets/create_mission_dialog.dart';
import 'package:tasktitans/features/missions/presentation/widgets/mission_approval_dialog.dart';
import 'package:tasktitans/features/missions/presentation/widgets/parent_hero_card.dart';

class ParentMissionsScreen extends ConsumerStatefulWidget {
  const ParentMissionsScreen({super.key});

  @override
  ConsumerState<ParentMissionsScreen> createState() =>
      _ParentMissionsScreenState();
}

class _ParentMissionsScreenState extends ConsumerState<ParentMissionsScreen> {
  MissionFilter _selectedFilter = MissionFilter.all;

  @override
  Widget build(BuildContext context) {
    final missionsAsync = ref.watch(missionsProvider);
    final parentProfile = ref.watch(userNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.lightningYellow,
      body: SafeArea(
        child: Column(
          children: [
            if (parentProfile != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: missionsAsync.when(
                  data: (missions) => ParentHeroCard(
                    parentProfile: parentProfile,
                    missions: missions,
                    selectedFilter: _selectedFilter,
                    onFilterSelected: (filter) =>
                        setState(() => _selectedFilter = filter),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) => const SizedBox(),
                ),
              ),
            Expanded(
              child: missionsAsync.when(
                data: (missions) {
                  final filteredMissions = _filterMissions(missions);

                  if (filteredMissions.isEmpty) {
                    return const Center(
                      child: Text(
                        'NO MISSIONS FOUND!',
                        style: TextStyle(fontFamily: 'Bungee', fontSize: 18),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredMissions.length,
                    itemBuilder: (context, index) {
                      final mission = filteredMissions[index];
                      return _buildMissionItem(context, ref, mission);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const CreateMissionDialog(),
          );
        },
        backgroundColor: AppColors.vigilanteRed,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  List<Mission> _filterMissions(List<Mission> missions) {
    switch (_selectedFilter) {
      case MissionFilter.all: // "OPEN"
        return missions
            .where((m) => m.status == MissionStatus.available)
            .toList();
      case MissionFilter.busy: // "ASSIGNED"
        return missions
            .where((m) => m.status == MissionStatus.inProgress)
            .toList();
      case MissionFilter.review: // "REVIEW"
        return missions
            .where((m) => m.status == MissionStatus.pendingApproval)
            .toList();
    }
  }

  Widget _buildMissionItem(
    BuildContext context,
    WidgetRef ref,
    Mission mission,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () => _showActionDialog(context, ref, mission),
        child: ComicCard(
          expand: false,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              // 1. Difficulty Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getDifficultyColor(mission.difficulty),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.comicBlack, width: 2),
                ),
                child: Icon(
                  _getDifficultyIcon(mission.difficulty),
                  color: mission.difficulty == MissionDifficulty.medium
                      ? AppColors.comicBlack
                      : Colors.white,
                ),
              ),
              const SizedBox(width: 12),

              // 2. Info Column
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
                    const SizedBox(height: 2),
                    _buildAssigneeBadge(ref, mission.assignedTo),
                    const SizedBox(height: 6),
                    Text(
                      '${mission.xpReward} XP  |  ${mission.goldReward} Gold',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: AppColors.midnightGrey,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Status Badge (Hugging right)
              _buildStatusBadge(mission.status),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssigneeBadge(WidgetRef ref, String? assignedToId) {
    if (assignedToId == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.halftoneGrey,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.comicBlack, width: 1),
        ),
        child: const Text(
          'OPEN TO ALL',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
        ),
      );
    }

    final profileAsync = ref.watch(profileByIdProvider(assignedToId));

    return profileAsync.when(
      data: (profile) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.electricBlue,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.comicBlack, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person, size: 10, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              profile?.username.toUpperCase() ?? 'UNKNOWN',
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox(width: 10, height: 10),
      error: (_, _) => const SizedBox(),
    );
  }

  void _showActionDialog(BuildContext context, WidgetRef ref, Mission mission) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
              const ComicHeader(text: 'MISSION ACTIONS', fontSize: 20),
              const SizedBox(height: 24),
              if (mission.status == MissionStatus.pendingApproval) ...[
                ComicButton(
                  text: 'REVIEW MISSION',
                  color: AppColors.hulkGreen,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) =>
                          MissionApprovalDialog(mission: mission),
                    );
                  },
                ),
                const SizedBox(height: 12),
              ],
              ComicButton(
                text: 'EDIT MISSION',
                color: AppColors.electricBlue,
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => CreateMissionDialog(mission: mission),
                  );
                },
              ),
              const SizedBox(height: 12),
              ComicButton(
                text: 'DELETE MISSION',
                color: AppColors.vigilanteRed,
                onPressed: () async {
                  await ref
                      .read(missionRepositoryProvider)
                      .deleteMission(mission.id);
                  ref.invalidate(missionsProvider);
                  if (context.mounted) Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(fontFamily: 'Bungee', color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
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
        return AppColors.epicPurple;
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

  Widget _buildStatusBadge(MissionStatus status) {
    Color color;
    String text;

    switch (status) {
      case MissionStatus.available:
        color = Colors.grey;
        text = 'OPEN';
        break;
      case MissionStatus.inProgress:
        color = AppColors.electricBlue;
        text = 'BUSY';
        break;
      case MissionStatus.pendingApproval:
        color = AppColors.lightningYellow;
        text = 'REVIEW';
        break;
      case MissionStatus.completed:
        color = AppColors.hulkGreen;
        text = 'DONE';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Bungee',
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    );
  }
}
