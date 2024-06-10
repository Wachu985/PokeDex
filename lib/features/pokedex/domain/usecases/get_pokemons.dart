import 'package:dartz/dartz.dart';
import 'package:pokedex_clean/core/error/failure.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/simple_pokemon.dart';
import 'package:pokedex_clean/features/pokedex/domain/repositories/pokedex_repository.dart';

class GetPokemons {
  const GetPokemons({required PokedexRepository repository})
      : _repository = repository;
  final PokedexRepository _repository;

  Future<Either<Failure, List<SimplePokemon>>> call(
          {limit = 20, offset = 0}) async =>
      await _repository.getPokemons(limit: limit, offset: offset);
}
