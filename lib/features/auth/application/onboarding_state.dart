import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stores temporary data during the multi-step onboarding process
final onboardingStateProvider = StateProvider<OnboardingState>((ref) => OnboardingState());

class OnboardingState {
  final String username;
  final String avatarId;
  final String pinCode;

  OnboardingState({
    this.username = '',
    this.avatarId = 'default_parent',
    this.pinCode = '',
  });

  OnboardingState copyWith({
    String? username,
    String? avatarId,
    String? pinCode,
  }) {
    return OnboardingState(
      username: username ?? this.username,
      avatarId: avatarId ?? this.avatarId,
      pinCode: pinCode ?? this.pinCode,
    );
  }
}
