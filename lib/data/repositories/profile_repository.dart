import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/data/providers/supabase_provider.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(supabaseProvider));
});

class ProfileRepository {
  final SupabaseClient _supabase;

  ProfileRepository(this._supabase);

  Future<List<Profile>> getProfiles(String familyId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('family_id', familyId);

    return (response as List).map((e) => Profile.fromJson(e)).toList();
  }

  Future<Profile> getProfile(String userId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return Profile.fromJson(response);
  }

  Future<Profile?> getProfileOrNull(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle(); // Returns null if not found
      
      if (response == null) return null;
      return Profile.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<Profile> createProfile(Profile profile) async {
    final response = await _supabase
        .from('profiles')
        .insert(profile.toJson())
        .select()
        .single();

    return Profile.fromJson(response);
  }
}
