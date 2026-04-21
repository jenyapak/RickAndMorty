class CharactersListInfo {
  final int count;
  final int pages;
  final String next;
  final String? prev;

  CharactersListInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory CharactersListInfo.fromMap(Map<String, dynamic> map) {
    return CharactersListInfo(
      count: map['count'] ?? 0,
      pages: map['pages'] ?? '',
      next: map['next'] ?? '',
      prev: map['prev'] ?? '',
    );
  }
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String dimension;
  final String gender;
  final String image;
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.dimension,
    required this.created,
    required this.image,
    required this.gender,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      species: map['species'] ?? '',
      type: map['type'] ?? '',
      dimension: map['dimension'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
      created: map['created'] != null
          ? DateTime.parse(map['created'])
          : DateTime.now(),
    );
  }
}
