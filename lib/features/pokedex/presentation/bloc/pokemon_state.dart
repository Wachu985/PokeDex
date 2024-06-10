part of 'pokemon_bloc.dart';

enum PokemonHomeStatus { initial, loading, error, success }

enum PokemonInfinityStatus { initial, loading, error, success }

enum PokemonDetailStatus { initial, loading, error, success }

enum PokemonFavoriteStatus { initial, loading, error, success }

class PokemonState extends Equatable {
  final PokemonHomeStatus pokemonHomeStatus;
  final PokemonDetailStatus pokemonDetailStatus;
  final PokemonInfinityStatus pokemonInfinityStatus;
  final PokemonFavoriteStatus pokemonFavoriteStatus;
  final List<SimplePokemon> listPokemons;
  final List<SimplePokemon> listFavorites;
  final Pokemon? selectedPokemon;
  final int navDrawler;
  final String errorText;
  final int offset;
  const PokemonState({
    this.pokemonHomeStatus = PokemonHomeStatus.initial,
    this.pokemonDetailStatus = PokemonDetailStatus.initial,
    this.pokemonInfinityStatus = PokemonInfinityStatus.initial,
    this.pokemonFavoriteStatus = PokemonFavoriteStatus.initial,
    this.offset = 0,
    this.navDrawler = 0,
    this.listPokemons = const [],
    this.listFavorites = const [],
    this.selectedPokemon,
    this.errorText = '',
  });

  factory PokemonState.initialState() => const PokemonState();

  PokemonState copyWith({
    PokemonHomeStatus? pokemonHomeStatus,
    PokemonDetailStatus? pokemonDetailStatus,
    PokemonInfinityStatus? pokemonInfinityStatus,
    PokemonFavoriteStatus? pokemonFavoriteStatus,
    List<SimplePokemon>? listPokemons,
    List<SimplePokemon>? listFavorites,
    int? offset,
    int? navDrawler,
    Pokemon? selectedPokemon,
    String? errorText,
  }) {
    return PokemonState(
      pokemonHomeStatus: pokemonHomeStatus ?? this.pokemonHomeStatus,
      pokemonDetailStatus: pokemonDetailStatus ?? this.pokemonDetailStatus,
      pokemonFavoriteStatus:
          pokemonFavoriteStatus ?? this.pokemonFavoriteStatus,
      pokemonInfinityStatus:
          pokemonInfinityStatus ?? this.pokemonInfinityStatus,
      errorText: errorText ?? this.errorText,
      offset: offset ?? this.offset,
      navDrawler: navDrawler ?? this.navDrawler,
      listPokemons: listPokemons ?? this.listPokemons,
      listFavorites: listFavorites ?? this.listFavorites,
      selectedPokemon: selectedPokemon ?? this.selectedPokemon,
    );
  }

  @override
  List<Object?> get props => [
        listPokemons,
        pokemonHomeStatus,
        selectedPokemon,
        errorText,
        pokemonDetailStatus,
        pokemonInfinityStatus,
        pokemonFavoriteStatus,
        offset,
        navDrawler,
        listFavorites,
      ];
}

extension PokemonStateExtension on PokemonState {
  bool get isHomeLoading => pokemonHomeStatus == PokemonHomeStatus.loading;
  bool get isHomeSuccess => pokemonHomeStatus == PokemonHomeStatus.success;
  bool get isHomeError => pokemonHomeStatus == PokemonHomeStatus.error;

  bool get isFavoriteLoading =>
      pokemonFavoriteStatus == PokemonFavoriteStatus.loading;
  bool get isFavoriteSuccess =>
      pokemonFavoriteStatus == PokemonFavoriteStatus.success;
  bool get isFavoriteError =>
      pokemonFavoriteStatus == PokemonFavoriteStatus.error;

  bool get isInfinityLoading =>
      pokemonInfinityStatus == PokemonInfinityStatus.loading;
  bool get isInfinitySuccess =>
      pokemonInfinityStatus == PokemonInfinityStatus.success;
  bool get isInfinityError =>
      pokemonInfinityStatus == PokemonInfinityStatus.error;

  bool get isDetailLoading =>
      pokemonDetailStatus == PokemonDetailStatus.loading;
  bool get isDetailSuccess =>
      pokemonDetailStatus == PokemonDetailStatus.success;
  bool get isDetailError => pokemonDetailStatus == PokemonDetailStatus.error;
}
