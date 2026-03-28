import '../remote/character_remote_resources.dart';
import '../../domain/character.dart';

class CharacterRepository {
  final CharacterRemoteSource remote;

  CharacterRepository(this.remote);

  Future<List<Character>> getCharacters() async {
    final models = await remote.fetchCharacters();

    return models
        .map((e) => Character(
      id: e.id,
      name: e.name,
      status: e.status,
      species: e.species,
      image: e.image,
    ))
        .toList();
  }
}