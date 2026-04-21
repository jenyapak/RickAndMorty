import 'package:flutter/material.dart';
import '../domain/entity/characters_entity.dart';
import '../domain/usecase/get_all_characters_usecase.dart';
import '../../../core/service/dio_client.dart';
import '../data/repository_impl/charaters_repository_impl.dart';

class AllCharactersListScreen extends StatefulWidget {
  const AllCharactersListScreen({super.key});

  @override
  State<AllCharactersListScreen> createState() =>
      _AllCharactersListScreenState();
}

class _AllCharactersListScreenState extends State<AllCharactersListScreen> {
  late Future<List<CharactersEntity>> _characterList;

  @override
  void initState() {
    super.initState();

    final networkService = NetworkService();
    final repository = CharacterRepositoryImpl(networkService.dio);
    final useCase = GetCharactersUseCase(repository);

    _characterList = useCase.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Characters')),
      body: FutureBuilder<List<CharactersEntity>>(
        future: _characterList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.image),
                  ),
                  title: Text(item.name),
                  subtitle: Text(item.status),
                );
              },
            );
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
