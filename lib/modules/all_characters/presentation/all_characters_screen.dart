import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/config/di.dart';
import 'package:rick_and_morty/core/extension/context_extension.dart';
import 'package:rick_and_morty/core/localization/generated/l10n.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_state.dart';
import 'package:rick_and_morty/modules/ui/common_text_field.dart';
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
  final _charactersCountValue = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CharactersBloc>()..add(LoadCharactersEvent()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextField(label: Language.of(context).findCharacter),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _charactersCountValue,
                      builder: (context, value, child) {
                        return Text(
                          '${Language.of(context).allCharacters}: $value',
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isGridViewValue,
                      builder: (context, isGrid, _) {
                        return IconButton(
                          onPressed: () {
                            _isGridViewValue.value = !_isGridViewValue.value;
                          },
                          icon: isGrid
                              ? Icon(Icons.grid_view)
                              : Icon(Icons.list),
                        );
                      },
                    ),
                  ],
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
                      return StreamBuilder<BlocState>(
                        stream: context.read<CharactersBloc>().stream,
                        initialData: context.read<CharactersBloc>().state,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          if (snapshot.data is BlocLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is BlocSuccess) {
                            WidgetsBinding.instance.addPostFrameCallback((
                              Duration duration,
                            ) {
                              _charactersCountValue.value =
                                  state.characters.length;
                            });
                            return ValueListenableBuilder<bool>(
                              valueListenable: _isGridViewValue,
                              builder: (context, isGridView, child) {
                                if (isGridView) {
                                  return GridView.builder(
                                    padding: const EdgeInsets.all(16),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 16,
                                        ),
                                    itemCount: state.characters.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: 120,
                                              height: 122,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  state.characters[index].image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            state.characters[index].status,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: _getStatusColor(
                                                state.characters[index].status,
                                                context,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            state.characters[index].name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${state.characters[index].species}, ${state.characters[index].gender}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 16),
                                  padding: EdgeInsets.zero,
                                  itemCount: state.characters.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                            state.characters[index].image,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.characters[index].status,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: _getStatusColor(
                                                  state
                                                      .characters[index]
                                                      .status,
                                                  context,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              state.characters[index].name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '${state.characters[index].species}, ${state.characters[index].gender}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
        ),
      ),
    );
  }
}

Color _getStatusColor(String status, BuildContext context) {
  switch (status) {
    case 'Alive':
      return context.colors.activeStatus;
    case 'Dead':
      return context.colors.deadStatus;
    default:
      return Colors.grey;
  }
}
