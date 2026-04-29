import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/config/di.dart';
import 'package:rick_and_morty/core/localization/generated/l10n.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_state.dart';
import 'package:rick_and_morty/providers/app_theme_provider.dart';
import 'package:rick_and_morty/providers/localization_provider.dart';

class AllCharactersListScreen extends StatefulWidget {
  const AllCharactersListScreen({super.key});

  @override
  State<AllCharactersListScreen> createState() =>
      _AllCharactersListScreenState();
}

class _AllCharactersListScreenState extends State<AllCharactersListScreen> {
  final _isGridViewValue = ValueNotifier<bool>(false);

  final _themeModeValue = ValueNotifier<ThemeMode>(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CharactersBloc>()..add(LoadCharactersEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text(Language.of(context).allCharacters)),
        body: Column(
          children: [
            IconButton(
              onPressed: () {
                _isGridViewValue.value = !_isGridViewValue.value;
              },
              icon: const Icon(Icons.grid_view),
            ),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: _themeModeValue,
              builder: (context, themeMode, child) {
                return ElevatedButton(
                  onPressed: () {
                    _themeModeValue.value = themeMode == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark;
                    context.read<AppThemeProvider>().changeThemeMode(
                      _themeModeValue.value,
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Language.of(context).changeTheme),
                      Icon(
                        themeMode == ThemeMode.dark
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<LocalizationProvider>().changeLocale(
                      Locale('en'),
                    );
                  },
                  child: Text('EN'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<LocalizationProvider>().changeLocale(
                      Locale('ru'),
                    );
                  },
                  child: Text('RU'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<LocalizationProvider>().changeLocale(
                      Locale('ky'),
                    );
                  },
                  child: Text('KG'),
                ),
              ],
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
