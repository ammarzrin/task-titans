import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasktitans/data/providers/supabase_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(supabaseProvider));
});

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  User? get currentUser => _supabase.auth.currentUser;

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Create a new family and the initial parent profile
  Future<void> createFamilyAndProfile({
    required String userId,
    required String familyName,
    required String username,
    required String avatarId,
    required String pinCode,
  }) async {
    // Call the Postgres Function (RPC)
    await _supabase.rpc('create_complete_family_account', params: {
      'family_name': familyName,
      'username': username,
      'avatar_id': avatarId,
      'pin_code': pinCode,
    });
  }

  // Join an existing family via invite code
  Future<void> joinFamilyAndCreateProfile({
    required String userId,
    required String inviteCode,
    required String username,
    required String avatarId,
    required String pinCode,
  }) async {
    // 1. Find Family by Invite Code
    final familyResponse = await _supabase
        .from('families')
        .select()
        .eq('invite_code', inviteCode)
        .maybeSingle();

    if (familyResponse == null) {
      throw Exception('Invalid invite code');
    }

    final familyId = familyResponse['id'] as String;

    // 2. Create Parent Profile linked to that family
    await _supabase.from('profiles').insert({
      'id': userId,
      'family_id': familyId,
      'role': 'parent',
      'username': username,
      'avatar_id': avatarId,
      'pin_code': pinCode,
    });
  }


  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
