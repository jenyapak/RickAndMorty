import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/service/dio_client.dart';
import 'package:rick_and_morty/modules/all_characters/data/model/characters_model.dart';
import 'package:rick_and_morty/modules/all_characters/domain/entity/characters_entity.dart';
import 'package:rick_and_morty/modules/all_characters/domain/repository/characters_domain_repository.dart';

@LazySingleton(as: CharactersDomainRepository)
class CharacterRepositoryImpl implements CharactersDomainRepository {
  final NetworkService networkService;
  CharacterRepositoryImpl(this.networkService);

  @override
  Future<List<CharactersEntity>> getAllCharacters() async {
    final response = await networkService.dio.get('api/character');
    final results = response.data['results'] as List;

    return results.map((e) {
      final model = CharactersModel.fromMap(e);
      return CharactersEntity(
        name: model.name,
        status: model.status,
        image: model.image,
      );
    }).toList();
  }
}
