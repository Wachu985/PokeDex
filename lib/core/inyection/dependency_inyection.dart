import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:isar/isar.dart';
import 'package:pokedex_clean/features/pokedex/data/datasources/local/isar_pokemon_local_datasource.dart';
import 'package:pokedex_clean/features/pokedex/data/datasources/local/pokemon_local_datasource.dart';
import 'package:pokedex_clean/features/pokedex/data/datasources/remote/dio_pokemon_remote_datasource.dart';
import 'package:pokedex_clean/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_clean/features/pokedex/data/models/simple_pokemon_model.dart';
import 'package:pokedex_clean/features/pokedex/data/repositories/pokedex_repository_impl.dart';
import 'package:pokedex_clean/features/pokedex/presentation/bloc/pokemon_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/pokedex/domain/domain.dart';
import '../network/network.dart';

class DependencyInyection {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    // Bloc
    sl.registerFactory(
      () => PokemonBloc(
        getPokemons: sl(),
        getOnePokemon: sl(),
        isPokemonFavorite: sl(),
        toogleFavorites: sl(),
        getFavorites: sl(),
        searchPokemon: sl(),
      ),
    );

    // UseCases
    sl.registerLazySingleton(() => GetPokemons(repository: sl()));
    sl.registerLazySingleton(() => GetOnePokemon(repository: sl()));
    sl.registerLazySingleton(() => GetFavorites(repository: sl()));
    sl.registerLazySingleton(() => IsPokemonFavorite(repository: sl()));
    sl.registerLazySingleton(() => ToogleFavorites(repository: sl()));
    sl.registerLazySingleton(() => SearchPokemon(repository: sl()));

    // Repository
    sl.registerLazySingleton<PokedexRepository>(() => PokedexRepositoryImpl(
        localDatasource: sl(), remoteDatasource: sl(), network: sl()));

    // Datasources
    sl.registerLazySingleton<PokemonRemoteDatasource>(
        () => DioPokemonRemoteDatasource(client: sl()));
    sl.registerLazySingleton<PokemonLocalDatasource>(
      () => IsarPokemonLocalDatasource(isar: sl()),
    );

    // Core
    sl.registerLazySingleton<NetworkInfo>(
        () => NetwotkInfoImpl(connection: sl()));

    // External
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => InternetConnectionChecker());
    sl.registerSingletonAsync(() async {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([SimplePokemonModelSchema], directory: dir.path);
    });
    await sl.allReady();
  }
}
