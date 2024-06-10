import '../../models/models.dart';

abstract class PokemonRemoteDatasource {
  Future<List<SimplePokemonModel>> getPokemons(
      {required int limit, required int offset});
  Future<PokemonModel> getOnePokemons(int pokemonId);
  Future<PokemonModel> searchPokemon(String pokemonName);
}
