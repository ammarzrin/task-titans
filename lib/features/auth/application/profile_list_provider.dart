import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/data/repositories/auth_repository.dart';
import 'package:tasktitans/data/repositories/profile_repository.dart';

final familyProfilesProvider = FutureProvider.autoDispose<List<Profile>?>((ref) async {
  final authRepo = ref.watch(authRepositoryProvider);
  final profileRepo = ref.watch(profileRepositoryProvider);

  final user = authRepo.currentUser;
  if (user == null) {
    throw Exception('No authenticated user found');
  }

  // Check if current user has a profile
  final currentProfile = await profileRepo.getProfileOrNull(user.id);
  
  if (currentProfile == null) {
     return null; // Signals that onboarding is needed
  }

  // 2. Fetch all profiles for that family
  return profileRepo.getProfiles(currentProfile.familyId);
});
