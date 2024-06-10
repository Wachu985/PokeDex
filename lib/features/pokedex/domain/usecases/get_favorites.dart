import 'package:dartz/dartz.dart';
import 'package:pokedex_clean/core/error/failure.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/simple_pokemon.dart';
import 'package:pokedex_clean/features/pokedex/domain/repositories/pokedex_repository.dart';

class GetFavorites {
  const GetFavorites({required PokedexRepository repository})
      : _repository = repository;
  final PokedexRepository _repository;

  Future<Either<Failure, List<SimplePokemon>>> call() async =>
      await _repository.getFavorites();
}
