import 'package:dio/dio.dart';
import '../../domain/entity/characters_entity.dart';
import '../../domain/repository/characters_domain_repository.dart';
import '../model/characters_model.dart';

class CharacterRepositoryImpl implements CharactersDomainRepository {
  final Dio dio;
  CharacterRepositoryImpl(this.dio);

  @override
  Future<List<CharactersEntity>> getAllCharacters() async {
    final response = await dio.get('/character');
    final results = response.data['results'] as List;

    return results.map((e) {
      final model = Character.fromMap(e);
      return CharactersEntity(
        name: model.name,
        status: model.status,
        image: model.image,
      );
    }).toList();
  }
}
