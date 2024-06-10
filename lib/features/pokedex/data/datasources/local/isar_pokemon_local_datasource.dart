import 'package:isar/isar.dart';
import 'package:pokedex_clean/features/pokedex/data/datasources/local/pokemon_local_datasource.dart';
import 'package:pokedex_clean/features/pokedex/data/models/simple_pokemon_model.dart';

import '../../../../../core/error/exception.dart';

class IsarPokemonLocalDatasource implements PokemonLocalDatasource {
  IsarPokemonLocalDatasource({required Isar isar}) : _isar = isar;
  final Isar _isar;
  @override
  Future<List<SimplePokemonModel>> getFavorites() async {
    try {
      final response = await _isar.simplePokemonModels.where().findAll();
      return response;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> toogleFavorite(SimplePokemonModel pokemon) async {
    try {
      final favoriteMedia = await _isar.simplePokemonModels
          .filter()
          .idEqualTo(pokemon.id)
          .findFirst();
      if (favoriteMedia != null) {
        _isar.writeTxnSync(
            () => _isar.simplePokemonModels.deleteSync(favoriteMedia.id));
        return true;
      }
      _isar.writeTxnSync(() => _isar.simplePokemonModels.putSync(pokemon));
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isPokemonFavorite(int pokemonId) async {
    final SimplePokemonModel? isFavoritePokemon = await _isar
        .simplePokemonModels
        .filter()
        .idEqualTo(pokemonId)
        .findFirst();
    return isFavoritePokemon != null;
  }
}
