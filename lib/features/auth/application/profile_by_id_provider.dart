import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktitans/data/models/profile.dart';
import 'package:tasktitans/data/repositories/profile_repository.dart';

final profileByIdProvider = FutureProvider.family<Profile?, String>((ref, id) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfileOrNull(id);
});
