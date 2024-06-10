import '../../models/models.dart';

abstract class PokemonLocalDatasource {
  Future<bool> toogleFavorite(SimplePokemonModel pokemon);
  Future<List<SimplePokemonModel>> getFavorites();
  Future<bool> isPokemonFavorite(int pokemonId);
}
