import '../../../../core/api_client.dart';
import '../model/character_model.dart';

class CharacterRemoteSource {
  final ApiClient client;

  CharacterRemoteSource(this.client);

  Future<List<CharacterModel>> fetchCharacters() async {
    final data = await client.get("/character");

    final results = data['results'] as List;

    return results
        .map((e) => CharacterModel.fromJson(e))
        .toList();
  }
}