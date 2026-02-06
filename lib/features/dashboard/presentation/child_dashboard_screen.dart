import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';
import 'package:tasktitans/features/dashboard/presentation/widgets/hero_stats_header.dart';
import 'package:tasktitans/features/missions/application/mission_list_provider.dart';
import 'package:tasktitans/features/missions/presentation/widgets/child_mission_card.dart';
import 'package:tasktitans/features/missions/presentation/widgets/mission_detail_dialog.dart';

class ChildDashboardScreen extends ConsumerWidget {
  const ChildDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProfile = ref.watch(userNotifierProvider);
    final missionsAsync = ref.watch(missionsProvider);

    if (activeProfile == null) {
      return const Scaffold(body: Center(child: Text('No Profile Selected')));
    }

    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HeroStatsHeader(profile: activeProfile),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ComicHeader(text: 'AVAILABLE MISSIONS', fontSize: 20),
            ),
            Expanded(
              child: missionsAsync.when(
                data: (missions) {
                  // Filter missions that are available or in_progress for this child
                  final displayMissions = missions.where((m) {
                    return m.status == MissionStatus.available || 
                           (m.status == MissionStatus.inProgress && m.assignedTo == activeProfile.id);
                  }).toList();

                  if (displayMissions.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sentiment_satisfied_alt, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            'ALL MISSIONS COMPLETE!\nWAIT FOR NEW ONES, TITAN!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Bungee',
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: displayMissions.length,
                    itemBuilder: (context, index) {
                      final mission = displayMissions[index];
                      return ChildMissionCard(
                        mission: mission,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => MissionDetailDialog(mission: mission),
                          );
                        },
                      );
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
    );
  }
}