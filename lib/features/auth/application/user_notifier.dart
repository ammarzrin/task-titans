import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/data/models/profile.dart';

final userNotifierProvider = StateNotifierProvider<UserNotifier, Profile?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<Profile?> {
  UserNotifier() : super(null);

  void selectProfile(Profile profile) {
    state = profile;
  }

  void logout() {
    state = null;
  }
  
  bool get isAuthenticated => state != null;
  
  bool get isParent => state?.role == UserRole.parent;
}
