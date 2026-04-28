// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:rick_and_morty/core/service/dio_client.dart' as _i317;
import 'package:rick_and_morty/modules/all_characters/data/repository_impl/charaters_repository_impl.dart'
    as _i512;
import 'package:rick_and_morty/modules/all_characters/domain/repository/characters_domain_repository.dart'
    as _i219;
import 'package:rick_and_morty/modules/all_characters/domain/usecase/get_all_characters_usecase.dart'
    as _i192;
import 'package:rick_and_morty/modules/all_characters/presentation/bloc/characters_bloc.dart'
    as _i844;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i317.NetworkService>(() => _i317.NetworkService());
    gh.lazySingleton<_i219.CharactersDomainRepository>(
      () => _i512.CharacterRepositoryImpl(gh<_i317.NetworkService>()),
    );
    gh.factory<_i192.GetCharactersUseCase>(
      () => _i192.GetCharactersUseCase(gh<_i219.CharactersDomainRepository>()),
    );
    gh.factory<_i844.CharactersBloc>(
      () => _i844.CharactersBloc(gh<_i192.GetCharactersUseCase>()),
    );
    return this;
  }
}
