import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/modules/all_characters/domain/entity/characters_entity.dart';
import 'package:rick_and_morty/modules/all_characters/domain/repository/characters_domain_repository.dart';

@injectable
class GetCharactersUseCase {
  final CharactersDomainRepository repository;
  GetCharactersUseCase(this.repository);

  Future<List<CharactersEntity>> call() async {
    return await repository.getAllCharacters();
  }
}
