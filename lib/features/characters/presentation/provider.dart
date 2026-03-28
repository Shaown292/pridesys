import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core/api_client.dart';
import '../data/local/character_local_source.dart';
import '../data/remote/character_remote_sources.dart';
import '../data/repository/character_repository.dart';
import '../domain/character.dart';

final apiClientProvider = Provider((ref) => ApiClient());

final remoteProvider = Provider(
  (ref) => CharacterRemoteSource(ref.read(apiClientProvider)),
);

final localProvider = Provider(
  (ref) => CharacterLocalSource(Hive.box<Map>('characters')),
);

final repositoryProvider = Provider(
  (ref) =>
      CharacterRepository(ref.read(remoteProvider), ref.read(localProvider)),
);

/// 🔥 MAIN LIST (offline-first)
final characterListProvider =
FutureProvider<List<Character>>((ref) async {
  final repo = ref.read(repositoryProvider);
  return repo.getCharacters(); // ✅ NOT direct API
});

/// 🔥 DETAIL PROVIDER (from cache)
final characterDetailProvider =
Provider.family<Character?, int>((ref, id) {
  final repo = ref.read(repositoryProvider);
  return repo.getCharacterById(id);
});

final editCharacterProvider = Provider((ref) => ref.read(repositoryProvider));
