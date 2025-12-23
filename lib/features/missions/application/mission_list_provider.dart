import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/data/repositories/mission_repository.dart';
import 'package:tasktitans/features/auth/application/user_notifier.dart';

// Provider to fetch missions for the current user's family
final missionsProvider = FutureProvider.autoDispose<List<Mission>>((ref) async {
  final user = ref.watch(userNotifierProvider);
  if (user == null) return [];

  final missionRepo = ref.watch(missionRepositoryProvider);
  return missionRepo.getMissions(user.familyId);
});
