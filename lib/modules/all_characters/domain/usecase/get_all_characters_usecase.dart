import '../entity/characters_entity.dart';
import '../repository/characters_domain_repository.dart';

class GetCharactersUseCase {
  final CharactersDomainRepository repository;
  GetCharactersUseCase(this.repository);

  Future<List<CharactersEntity>> call() async {
    return await repository.getAllCharacters();
  }
}
