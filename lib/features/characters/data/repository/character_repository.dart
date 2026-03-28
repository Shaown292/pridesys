import 'package:hive/hive.dart';

import '../model/character_model.dart';
import '../local/character_local_source.dart';
import '../../domain/character.dart';
import '../remote/character_remote_sources.dart';

class CharacterRepository {
  final CharacterRemoteSource remote;
  final CharacterLocalSource local;

  CharacterRepository(this.remote, this.local);

  Future<List<Character>> getCharacters() async {
    try {
      final apiData = await remote.fetchCharacters();

      // ✅ cache
      await local.cacheCharacters(apiData);

      return _map(apiData);
    } catch (e) {
      // ✅ fallback to cache
      final cached = local.getCachedCharacters();

      if (cached.isEmpty) rethrow;

      return _map(cached);
    }
  }

  Character? getCharacterById(int id) {
    final model = local.getCharacter(id);
    if (model == null) return null;

    return _mapSingle(model);
  }

  List<Character> _map(List<CharacterModel> list) {
    return list.map(_mapSingle).toList();
  }

  Character _mapSingle(CharacterModel e) {
    return Character(
      id: e.id,
      name: e.name,
      status: e.status,
      species: e.species,
      image: e.image,
      type: e.type,
      gender: e.gender,
      episode: e.episode,
      created: e.created,
      originName: e.originName,
    );
  }

  Future<void> updateCharacter(Character character) async {
    final model = CharacterModel(
      id: character.id,
      name: character.name,
      status: character.status,
      species: character.species,
      type: character.type,
      gender: character.gender,
      image: character.image,
      episode: character.episode,
      created: character.created,
      originName: character.originName,
    );

    await local.updateCharacter(model);
  }
}
