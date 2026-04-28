import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/modules/all_characters/domain/usecase/get_all_characters_usecase.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_state.dart';

import 'characters_event.dart';

@injectable
class CharactersBloc extends Bloc<BlocEvent, BlocState> {
  final GetCharactersUseCase getCharactersUseCase;

  CharactersBloc(this.getCharactersUseCase) : super(BlocInitial()) {
    on<LoadCharactersEvent>((event, emit) async {
      emit(BlocLoading());
      try {
        final result = await getCharactersUseCase.call();
        emit(BlocSuccess(result));
      } catch (e) {
        emit(BlocError("Ошибка загрузки"));
      }
    });
  }
}
