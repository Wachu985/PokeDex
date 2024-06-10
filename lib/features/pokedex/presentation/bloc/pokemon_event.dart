part of 'pokemon_bloc.dart';

sealed class PokemonEvent {
  factory PokemonEvent.getAllPokemons() => GetAllPokemons();
  factory PokemonEvent.searchPokemonEvent({required String text}) =>
      SearchPokemonEvent(text: text);
  factory PokemonEvent.changeDrawlerEvent({required int newDrawler}) =>
      ChangeDrawlerEvent(newDrawler: newDrawler);
  factory PokemonEvent.getFavoritesEvent() => GetFavoritesEvent();
  factory PokemonEvent.getOnePokemon({required int pokemonId}) =>
      GetOnePokemonEvent(pokemonId: pokemonId);
  factory PokemonEvent.toogleFavorite({required SimplePokemon pokemon}) =>
      ToogleFavoritesEvent(pokemon: pokemon);
}

class GetAllPokemons implements PokemonEvent {}

class SearchPokemonEvent implements PokemonEvent {
  final String text;

  SearchPokemonEvent({required this.text});
}

class ChangeDrawlerEvent implements PokemonEvent {
  final int newDrawler;

  ChangeDrawlerEvent({required this.newDrawler});
}

class GetFavoritesEvent implements PokemonEvent {}

class GetOnePokemonEvent implements PokemonEvent {
  final int pokemonId;

  GetOnePokemonEvent({required this.pokemonId});
}

class ToogleFavoritesEvent implements PokemonEvent {
  final SimplePokemon pokemon;

  ToogleFavoritesEvent({required this.pokemon});
}
