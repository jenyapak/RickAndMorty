import 'package:rick_and_morty/modules/all_characters/domain/entity/characters_entity.dart';

abstract class BlocState {}

class BlocInitial extends BlocState {}

class BlocLoading extends BlocState {}

class BlocSuccess extends BlocState {
  final List<CharactersEntity> characters;
  BlocSuccess(this.characters);
}

class BlocError extends BlocState {
  final String message;
  BlocError(this.message);
}
