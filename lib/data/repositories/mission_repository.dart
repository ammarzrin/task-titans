import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasktitans/data/models/mission.dart';
import 'package:tasktitans/data/providers/supabase_provider.dart';

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepository(ref.watch(supabaseProvider));
});

class MissionRepository {
  final SupabaseClient _supabase;

  MissionRepository(this._supabase);

  // Fetch all missions for a family
  Future<List<Mission>> getMissions(String familyId) async {
    final response = await _supabase
        .from('missions')
        .select()
        .eq('family_id', familyId)
        .order('status', ascending: true); // Show available first

    return (response as List).map((e) => Mission.fromJson(e)).toList();
  }

  // Create a new mission
  Future<void> createMission(Mission mission) async {
    // We exclude 'id' to let Supabase generate it
    final json = mission.toJson();
    json.remove('id'); 
    
    await _supabase.from('missions').insert(json);
  }

  // Update mission status (e.g., Parent approves)
  Future<void> updateMissionStatus(String missionId, MissionStatus status) async {
    // Note: status.name gives 'inProgress', but we need 'in_progress' for DB enum
    // We can use the JsonKey annotation logic if we had a helper, but manual map is safe here
    String statusString;
    switch (status) {
      case MissionStatus.available: statusString = 'available'; break;
      case MissionStatus.inProgress: statusString = 'in_progress'; break;
      case MissionStatus.pendingApproval: statusString = 'pending_approval'; break;
      case MissionStatus.completed: statusString = 'completed'; break;
    }

    await _supabase
        .from('missions')
        .update({'status': statusString})
        .eq('id', missionId);
  }
}
