import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api_client.dart';
import '../data/remote/character_remote_resources.dart';
import '../data/repository/character_repository.dart';
import '../domain/character.dart';

final apiClientProvider = Provider((ref) => ApiClient());

final remoteProvider = Provider(
      (ref) => CharacterRemoteSource(ref.read(apiClientProvider)),
);

final repositoryProvider = Provider(
      (ref) => CharacterRepository(ref.read(remoteProvider)),
);

final characterListProvider =
FutureProvider<List<Character>>((ref) async {
  final repo = ref.read(repositoryProvider);
  return repo.getCharacters();
});