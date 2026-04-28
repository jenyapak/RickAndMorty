import 'package:rick_and_morty/modules/all_characters/domain/entity/characters_entity.dart';

abstract class CharactersDomainRepository {
  Future<List<CharactersEntity>> getAllCharacters();
}
