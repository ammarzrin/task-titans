import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/data/repositories/family_repository.dart';

enum MissionFilter { all, busy, review }

class ParentHeroCard extends ConsumerWidget {
  final Profile parentProfile;
  final List<Mission> missions;
  final MissionFilter selectedFilter;
  final ValueChanged<MissionFilter> onFilterSelected;

  const ParentHeroCard({
    super.key,
    required this.parentProfile,
    required this.missions,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(familyProvider(parentProfile.familyId));

    final totalTasks =
        missions.length; // Or filter by 'available' if 'ALL' means 'OPEN'
    // Let's assume 'ALL' implies 'OPEN/AVAILABLE' based on the request context,
    // or strictly 'ALL' missions. The prompt says "Open tasks, Busy/Assigned tasks, and Review Tasks".
    // So let's map:
    // - ALL -> OPEN (Available & Unassigned)
    // - BUSY -> ASSIGNED (In Progress)
    // - REVIEW -> PENDING APPROVAL

    // Actually, usually 'ALL' is a summary. But the prompt asks to toggle *between* them.
    // Let's calculate counts based on status to be helpful.
    final openTasks = missions
        .where((m) => m.status == MissionStatus.available)
        .length;
    final busyTasks = missions
        .where((m) => m.status == MissionStatus.inProgress)
        .length;
    final reviewTasks = missions
        .where((m) => m.status == MissionStatus.pendingApproval)
        .length;

    return ComicCard(
      backgroundColor: AppColors.pureWhite,
      padding: const EdgeInsets.all(16),
      expand: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Parent Username
          Text(
            parentProfile.username.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Bungee',
              fontSize: 24,
              color: AppColors.comicBlack,
            ),
          ),

          // Row 2: Family Name
          familyAsync.when(
            data: (family) => Text(
              family?.name.toUpperCase() ?? 'SQUAD HQ',
              style: const TextStyle(
                fontFamily: 'Bungee',
                fontSize: 14,
                color: AppColors.midnightGrey,
              ),
            ),
            loading: () => const SizedBox(height: 14),
            error: (_, _) => const Text('TITAN SQUAD'),
          ),

          const SizedBox(height: 16),

          // Row 3: Stats Containers (Clickable Filters)
          Row(
            children: [
              Expanded(
                child: _buildStatBox(
                  'OPEN',
                  openTasks.toString(),
                  AppColors.halftoneGrey,
                  AppColors.comicBlack,
                  MissionFilter.all,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatBox(
                  'BUSY',
                  busyTasks.toString(),
                  AppColors.electricBlue,
                  Colors.white,
                  MissionFilter.busy,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatBox(
                  'REVIEW',
                  reviewTasks.toString(),
                  AppColors.lightningYellow,
                  AppColors.comicBlack,
                  MissionFilter.review,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(
    String label,
    String value,
    Color bgColor,
    Color textColor,
    MissionFilter filter,
  ) {
    final isSelected = selectedFilter == filter;

    return GestureDetector(
      onTap: () => onFilterSelected(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: isSelected ? AppColors.comicBlack : AppColors.comicBlack,
            width: isSelected ? 3 : 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: AppColors.comicBlack,
                    offset: Offset(0, 4),
                    blurRadius: 0,
                  ),
                ]
              : [],
        ),
        transform: isSelected
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Bungee',
                fontSize: 18,
                color: textColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Bungee',
                fontSize: 10, // Adjusted for better fit
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
