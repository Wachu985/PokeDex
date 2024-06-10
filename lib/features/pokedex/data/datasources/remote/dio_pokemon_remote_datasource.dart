import 'package:dio/dio.dart';
import 'package:pokedex_clean/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_clean/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_clean/features/pokedex/data/models/simple_pokemon_model.dart';

import '../../../../../core/error/exception.dart';

class DioPokemonRemoteDatasource implements PokemonRemoteDatasource {
  DioPokemonRemoteDatasource({
    required Dio client,
  }) : _client = client;
  final Dio _client;
  @override
  Future<PokemonModel> getOnePokemons(int pokemonId) async {
    try {
      final response =
          await _client.get('https://pokeapi.co/api/v2/pokemon/$pokemonId/');
      if (response.statusCode == 200) {
        return PokemonModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<SimplePokemonModel>> getPokemons(
      {required int limit, required int offset}) async {
    try {
      final response = await _client
          .get('https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset');
      if (response.statusCode == 200) {
        final results = response.data['results'] as List;

        return results
            .map((pokemon) => SimplePokemonModel.fromMap(pokemon))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<PokemonModel> searchPokemon(String pokemonName) async {
    try {
      final response =
          await _client.get('https://pokeapi.co/api/v2/pokemon/$pokemonName/');
      if (response.statusCode == 200) {
        return PokemonModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
