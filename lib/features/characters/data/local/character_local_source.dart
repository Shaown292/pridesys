import 'package:hive/hive.dart';

import '../model/character_model.dart';

class CharacterLocalSource {
  final Box<Map> box;

  CharacterLocalSource(this.box);

  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    final data = {
      for (var c in characters) c.id: c.toJson(),
    };

    await box.putAll(data);
  }

  List<CharacterModel> getCachedCharacters() {
    return box.values
        .map((e) => CharacterModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  CharacterModel? getCharacter(int id) {
    final data = box.get(id);
    if (data == null) return null;

    return CharacterModel.fromJson(Map<String, dynamic>.from(data));
  }
}