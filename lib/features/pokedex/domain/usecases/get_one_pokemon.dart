import 'package:dartz/dartz.dart';
import 'package:pokedex_clean/core/error/failure.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_clean/features/pokedex/domain/repositories/pokedex_repository.dart';

class GetOnePokemon {
  const GetOnePokemon({required PokedexRepository repository})
      : _repository = repository;
  final PokedexRepository _repository;

  Future<Either<Failure, Pokemon>> call({required int pokemonId}) async =>
      await _repository.getOnePokemon(pokemonId);
}
