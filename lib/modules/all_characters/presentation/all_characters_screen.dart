import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/config/di.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_state.dart';

class AllCharactersListScreen extends StatelessWidget {
  AllCharactersListScreen({super.key});

  final _isGridViewValue = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CharactersBloc>()..add(LoadCharactersEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('All Characters')),
        body: Column(
          children: [
            IconButton(
              onPressed: () {
                _isGridViewValue.value = !_isGridViewValue.value;
              },
              icon: const Icon(Icons.grid_view),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final bloc = context.read<CharactersBloc>();

                  return StreamBuilder<BlocState>(
                    stream: bloc.stream,
                    initialData: bloc.state,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      if (state is BlocLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is BlocSuccess) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: _isGridViewValue,
                          builder: (context, isGridView, child) {
                            if (isGridView) {
                              return GridView.builder(
                                padding: const EdgeInsets.all(16),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                    ),
                                itemCount: state.characters.length,
                                itemBuilder: (context, index) {
                                  final char = state.characters[index];
                                  return GridTile(
                                    footer: GridTileBar(
                                      backgroundColor: Colors.black54,
                                      title: Text(char.name),
                                    ),
                                    child: Image.network(
                                      char.image,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }

                            return ListView.builder(
                              itemCount: state.characters.length,
                              itemBuilder: (context, index) {
                                final char = state.characters[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(char.image),
                                  ),
                                  title: Text(char.name),
                                  subtitle: Text(char.status),
                                );
                              },
                            );
                          },
                        );
                      }

                      if (state is BlocError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
