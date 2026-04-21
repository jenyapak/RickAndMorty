import '../entity/characters_entity.dart';

abstract class CharactersDomainRepository {
  Future<List<CharactersEntity>> getAllCharacters();
}
