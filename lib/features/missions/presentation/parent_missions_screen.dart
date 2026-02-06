import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_card.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/features/missions/application/mission_list_provider.dart';
import 'package:tasktitans/features/missions/presentation/widgets/create_mission_dialog.dart';
import 'package:tasktitans/features/missions/presentation/widgets/mission_approval_dialog.dart';

class ParentMissionsScreen extends ConsumerWidget {
  const ParentMissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missionsAsync = ref.watch(missionsProvider);

    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const ComicHeader(text: 'MISSION CONTROL', fontSize: 24),
            const SizedBox(height: 20),
            Expanded(
              child: missionsAsync.when(
                data: (missions) {
                  if (missions.isEmpty) {
                    return const Center(child: Text('NO MISSIONS YET!'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: missions.length,
                    itemBuilder: (context, index) {
                      final mission = missions[index];
                      return _buildMissionItem(context, mission);
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
        shape: const CircleBorder(side: BorderSide(color: Colors.black, width: 2)),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildMissionItem(BuildContext context, Mission mission) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          if (mission.status == MissionStatus.pendingApproval) {
            showDialog(
              context: context,
              builder: (context) => MissionApprovalDialog(mission: mission),
            );
          }
        },
        child: ComicCard(
          expand: false,
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.electricBlue,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2),
              ),
              child: const Icon(Icons.star, color: Colors.white),
            ),
            title: Text(
              mission.title,
              style: const TextStyle(fontFamily: 'Bungee', fontSize: 16),
            ),
            subtitle: Text(
              '${mission.xpReward} XP  |  ${mission.goldReward} GOLD',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: _buildStatusBadge(mission.status),
          ),
        ),
      ),
    );
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
        style: const TextStyle(fontFamily: 'Bungee', fontSize: 10, color: Colors.black),
      ),
    );
  }
}