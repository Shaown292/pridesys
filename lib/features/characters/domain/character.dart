class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final List<String> episode;
  final String created;
  final String originName;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.episode,
    required this.created,
    required this.originName,
  });

  Character copyWith({
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? image,
    List<String>? episode,
    String? created,
    String? originName,
  }) {
    return Character(
      id: id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      created: created ?? this.created,
      originName: originName ?? this.originName,
    );
  }

}