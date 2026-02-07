import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasktitans/data/models/family.dart';
import 'package:tasktitans/data/providers/supabase_provider.dart';

final familyRepositoryProvider = Provider<FamilyRepository>((ref) {
  return FamilyRepository(ref.watch(supabaseProvider));
});

class FamilyRepository {
  final SupabaseClient _supabase;

  FamilyRepository(this._supabase);

  Future<Family?> getFamily(String id) async {
    final response = await _supabase
        .from('families')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return Family.fromJson(response);
  }
}

final familyProvider = FutureProvider.family<Family?, String>((ref, id) async {
  final repo = ref.watch(familyRepositoryProvider);
  return repo.getFamily(id);
});
