import 'package:dartz/dartz.dart';
import 'package:pokedex_clean/core/error/failure.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/simple_pokemon.dart';
import 'package:pokedex_clean/features/pokedex/domain/repositories/pokedex_repository.dart';

class ToogleFavorites {
  const ToogleFavorites({required PokedexRepository repository})
      : _repository = repository;
  final PokedexRepository _repository;

  Future<Either<Failure, bool>> call({required SimplePokemon pokemon}) async =>
      await _repository.toogleFavorite(pokemon);
}
