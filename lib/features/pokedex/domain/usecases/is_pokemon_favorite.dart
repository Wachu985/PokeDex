import 'package:dartz/dartz.dart';
import 'package:pokedex_clean/core/error/failure.dart';
import 'package:pokedex_clean/features/pokedex/domain/repositories/pokedex_repository.dart';

class IsPokemonFavorite {
  const IsPokemonFavorite({required PokedexRepository repository})
      : _repository = repository;
  final PokedexRepository _repository;

  Future<Either<Failure, bool>> call({required int pokemonId}) async =>
      await _repository.isPokemonFavorite(pokemonId);
}
