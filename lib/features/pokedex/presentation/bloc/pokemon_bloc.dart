import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(
      {required GetPokemons getPokemons,
      required GetOnePokemon getOnePokemon,
      required GetFavorites getFavorites,
      required SearchPokemon searchPokemon,
      required IsPokemonFavorite isPokemonFavorite,
      required ToogleFavorites toogleFavorites})
      : _getPokemons = getPokemons,
        _getOnePokemon = getOnePokemon,
        _getFavorites = getFavorites,
        _searchPokemon = searchPokemon,
        _isPokemonFavorite = isPokemonFavorite,
        _toogleFavorites = toogleFavorites,
        super(PokemonState.initialState()) {
    on<GetAllPokemons>(getAllPokemons);
    on<ToogleFavoritesEvent>(toogleFavoritesPokemon);
    on<GetFavoritesEvent>(getFavoritesEvent);
    on<GetOnePokemonEvent>(getOnePokemonEvent);
    on<ChangeDrawlerEvent>(changeDrawlerEvent);
    on<SearchPokemonEvent>(searchPokemonEvent);
  }
  final GetPokemons _getPokemons;
  final GetOnePokemon _getOnePokemon;
  final SearchPokemon _searchPokemon;
  final GetFavorites _getFavorites;
  final IsPokemonFavorite _isPokemonFavorite;
  final ToogleFavorites _toogleFavorites;

  late final ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  void init() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 500 &&
          !state.isInfinityLoading) {
        add(PokemonEvent.getAllPokemons());
      }
    });
  }

  FutureOr<void> getAllPokemons(
      GetAllPokemons event, Emitter<PokemonState> emit) async {
    if (state.offset == 0) {
      emit(state.copyWith(pokemonHomeStatus: PokemonHomeStatus.loading));
    } else {
      emit(
          state.copyWith(pokemonInfinityStatus: PokemonInfinityStatus.loading));
    }
    final results = await _getPokemons(offset: state.offset);
    results.fold(
        (error) => emit(state.copyWith(
              errorText: error.message,
              pokemonHomeStatus: PokemonHomeStatus.error,
              pokemonInfinityStatus: PokemonInfinityStatus.error,
            )),
        (success) => emit(state.copyWith(
                listPokemons: [
                  if (state.offset != 0) ...state.listPokemons,
                  ...success
                ],
                pokemonHomeStatus: PokemonHomeStatus.success,
                pokemonInfinityStatus: PokemonInfinityStatus.success,
                offset: state.offset + 20)));
  }

  FutureOr<void> toogleFavoritesPokemon(
      ToogleFavoritesEvent event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(pokemonFavoriteStatus: PokemonFavoriteStatus.loading));
    final response = await _toogleFavorites(pokemon: event.pokemon);
    response.fold(
        (error) => emit(state.copyWith(
            errorText: error.message,
            pokemonFavoriteStatus: PokemonFavoriteStatus.error)),
        (success) => emit(state.copyWith(
            pokemonFavoriteStatus: PokemonFavoriteStatus.success)));
    add(PokemonEvent.getFavoritesEvent());
  }

  Future<bool> isFavorite(int pokemonId) async {
    final response = await _isPokemonFavorite(pokemonId: pokemonId);
    return response.fold((error) => false, (success) => success);
  }

  FutureOr<void> getFavoritesEvent(
      GetFavoritesEvent event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(pokemonFavoriteStatus: PokemonFavoriteStatus.loading));

    final response = await _getFavorites();
    response.fold(
      (error) => emit(state.copyWith(
          pokemonFavoriteStatus: PokemonFavoriteStatus.error,
          errorText: error.message)),
      (success) => emit(
        state.copyWith(
          pokemonFavoriteStatus: PokemonFavoriteStatus.success,
          listFavorites: success,
        ),
      ),
    );
  }

  FutureOr<void> getOnePokemonEvent(
      GetOnePokemonEvent event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(pokemonDetailStatus: PokemonDetailStatus.loading));
    final response = await _getOnePokemon(pokemonId: event.pokemonId);
    response.fold(
        (error) => emit(state.copyWith(
            errorText: error.message,
            pokemonDetailStatus: PokemonDetailStatus.error)),
        (success) => emit(state.copyWith(
            pokemonDetailStatus: PokemonDetailStatus.success,
            selectedPokemon: success)));
  }

  FutureOr<void> changeDrawlerEvent(
      ChangeDrawlerEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(navDrawler: event.newDrawler));
  }

  FutureOr<void> searchPokemonEvent(
      SearchPokemonEvent event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(pokemonDetailStatus: PokemonDetailStatus.loading));
    final response =
        await _searchPokemon(pokemonName: event.text.toLowerCase().trim());
    response.fold(
        (error) => emit(state.copyWith(
            errorText: error.message,
            pokemonDetailStatus: PokemonDetailStatus.error)),
        (success) => emit(state.copyWith(
            pokemonDetailStatus: PokemonDetailStatus.success,
            selectedPokemon: success)));
  }

  @override
  Future<void> close() {
    _scrollController.dispose();
    return super.close();
  }
}
