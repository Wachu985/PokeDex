import 'package:dartz/dartz.dart';
import 'package:pokedex_clean/core/error/failure.dart';
import 'package:pokedex_clean/features/pokedex/data/datasources/local/pokemon_local_datasource.dart';
import 'package:pokedex_clean/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_clean/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_clean/features/pokedex/data/models/simple_pokemon_model.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/simple_pokemon.dart';
import 'package:pokedex_clean/features/pokedex/domain/repositories/pokedex_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  PokedexRepositoryImpl(
      {required PokemonLocalDatasource localDatasource,
      required PokemonRemoteDatasource remoteDatasource,
      required NetworkInfo network})
      : _localDatasource = localDatasource,
        _remoteDatasource = remoteDatasource,
        _network = network;
  final PokemonLocalDatasource _localDatasource;
  final PokemonRemoteDatasource _remoteDatasource;
  final NetworkInfo _network;
  @override
  Future<Either<Failure, List<SimplePokemon>>> getFavorites() async {
    try {
      if (await _network.isConnected) {
        final results = await _localDatasource.getFavorites();

        return Right(
            results.map((pokemon) => pokemon.toSimplePokemon).toList());
      } else {
        return const Left(CacheFailure(
            message: 'Ha ocurrido un error al obtener favoritos.'));
      }
    } on ServerException {
      return const Left(
          NetworkFailure(message: "Ha ocurrido un error de conexión."));
    } on CacheException {
      return const Left(
          CacheFailure(message: "Ha ocurrido un error al obtener favoritos."));
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getOnePokemon(int pokemonId) async {
    try {
      if (await _network.isConnected) {
        final results = await _remoteDatasource.getOnePokemons(pokemonId);

        return Right(results.toPokemon);
      } else {
        return const Left(
            NetworkFailure(message: "Ha ocurrido un error de conexión."));
      }
    } on ServerException {
      return const Left(
          NetworkFailure(message: "Ha ocurrido un error de conexión."));
    } on CacheException {
      return const Left(CacheFailure(
          message: "Ha ocurrido un Ha ocurrido un error de cache.."));
    }
  }

  @override
  Future<Either<Failure, List<SimplePokemon>>> getPokemons(
      {required int limit, required int offset}) async {
    try {
      if (await _network.isConnected) {
        final results =
            await _remoteDatasource.getPokemons(limit: limit, offset: offset);

        return Right(
            results.map((pokemon) => pokemon.toSimplePokemon).toList());
      } else {
        return const Left(
            NetworkFailure(message: "Ha ocurrido un error de conexión."));
      }
    } on ServerException {
      return const Left(
          NetworkFailure(message: "Ha ocurrido un error de conexión."));
    } on CacheException {
      return const Left(
          CacheFailure(message: "Ha ocurrido un error de cache."));
    }
  }

  @override
  Future<Either<Failure, bool>> isPokemonFavorite(int pokemonId) async {
    try {
      if (await _network.isConnected) {
        final results = await _localDatasource.isPokemonFavorite(pokemonId);

        return Right(results);
      } else {
        return const Left(
            CacheFailure(message: 'Ha ocurrido un error de cache.'));
      }
    } on ServerException {
      return const Left(
          NetworkFailure(message: "Ha ocurrido un error de conexión."));
    } on CacheException {
      return const Left(
          CacheFailure(message: "Ha ocurrido un error de cache."));
    }
  }

  @override
  Future<Either<Failure, bool>> toogleFavorite(SimplePokemon pokemonId) async {
    try {
      if (await _network.isConnected) {
        final results = await _localDatasource.toogleFavorite(
            SimplePokemonModel(
                id: pokemonId.id, name: pokemonId.name, url: pokemonId.url));

        return Right(results);
      } else {
        return const Left(
            CacheFailure(message: 'Ha ocurrido un error de cache.'));
      }
    } on ServerException {
      return const Left(
          NetworkFailure(message: "Ha ocurrido un error de conexión."));
    } on CacheException {
      return const Left(
          CacheFailure(message: "Ha ocurrido un error de cache."));
    }
  }

  @override
  Future<Either<Failure, Pokemon>> searchPokemon(String pokemonName) async {
    try {
      if (await _network.isConnected) {
        final results = await _remoteDatasource.searchPokemon(pokemonName);

        return Right(results.toPokemon);
      } else {
        return const Left(
            NetworkFailure(message: "Ha ocurrido un error de conexión."));
      }
    } on ServerException {
      return const Left(
          NetworkFailure(message: "Su pokemon no ha sido encontrado.."));
    } on CacheException {
      return const Left(CacheFailure(
          message: "Ha ocurrido un Ha ocurrido un error de cache.."));
    }
  }
}
