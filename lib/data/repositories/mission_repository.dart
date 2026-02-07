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

  // Update an existing mission
  Future<void> updateMission(Mission mission) async {
    final json = mission.toJson();
    final id = json.remove('id');
    
    await _supabase.from('missions').update(json).eq('id', id);
  }

  // Delete a mission
  Future<void> deleteMission(String missionId) async {
    await _supabase.from('missions').delete().eq('id', missionId);
  }

  // Parent approves mission and awards rewards via RPC
  Future<void> approveMission(String missionId) async {
    await _supabase.rpc('approve_mission', params: {'mission_id': missionId});
  }

  // Update mission status (e.g., Parent approves)
  Future<void> updateMissionStatus(String missionId, MissionStatus status) async {
    final statusString = _getStatusString(status);

    await _supabase
        .from('missions')
        .update({'status': statusString})
        .eq('id', missionId);
  }

  // Child claims a mission
  Future<void> claimMission(String missionId, String childId) async {
    await _supabase.from('missions').update({
      'status': 'in_progress',
      'assigned_to': childId,
    }).eq('id', missionId);
  }

  // Child marks mission as complete
  Future<void> completeMission(String missionId) async {
    await _supabase.from('missions').update({
      'status': 'pending_approval',
    }).eq('id', missionId);
  }

  String _getStatusString(MissionStatus status) {
    switch (status) {
      case MissionStatus.available: return 'available';
      case MissionStatus.inProgress: return 'in_progress';
      case MissionStatus.pendingApproval: return 'pending_approval';
      case MissionStatus.completed: return 'completed';
    }
  }
}
