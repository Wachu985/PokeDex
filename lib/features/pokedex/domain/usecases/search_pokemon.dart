import 'package:dartz/dartz.dart';
import 'package:pokedex_clean/core/error/failure.dart';
import 'package:pokedex_clean/features/pokedex/domain/repositories/pokedex_repository.dart';

import '../entities/pokemon.dart';

class SearchPokemon {
  const SearchPokemon({required PokedexRepository repository})
      : _repository = repository;
  final PokedexRepository _repository;

  Future<Either<Failure, Pokemon>> call({required String pokemonName}) async =>
      await _repository.searchPokemon(pokemonName);
}
