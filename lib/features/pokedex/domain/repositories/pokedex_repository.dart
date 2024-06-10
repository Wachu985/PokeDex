import 'package:dartz/dartz.dart';
import 'package:pokedex_clean/core/error/failure.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/simple_pokemon.dart';

abstract class PokedexRepository {
  Future<Either<Failure, List<SimplePokemon>>> getPokemons(
      {required int limit, required int offset});
  Future<Either<Failure, Pokemon>> getOnePokemon(int pokemonId);
  Future<Either<Failure, bool>> toogleFavorite(SimplePokemon pokemonId);
  Future<Either<Failure, List<SimplePokemon>>> getFavorites();
  Future<Either<Failure, bool>> isPokemonFavorite(int pokemonId);
  Future<Either<Failure, Pokemon>> searchPokemon(String pokemonName);
}
