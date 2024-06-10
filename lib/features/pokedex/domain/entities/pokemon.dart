import '../domain.dart';

class Pokemon {
  int baseExperience;
  int height;
  int id;
  List<MoveElement> moves;
  String name;
  Sprites sprites;
  List<Stat> stats;
  int weight;

  Pokemon({
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.moves,
    required this.name,
    required this.sprites,
    required this.stats,
    required this.weight,
  });
}

class MoveElement {
  MoveMove move;

  MoveElement({
    required this.move,
  });
}

class MoveMove {
  String name;
  String url;

  MoveMove({
    required this.name,
    required this.url,
  });
}

class Sprites {
  String backDefault;
  dynamic backFemale;
  String backShiny;
  dynamic backShinyFemale;
  String frontDefault;
  dynamic frontFemale;
  String frontShiny;
  dynamic frontShinyFemale;

  Sprites({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });
}

class Stat {
  int baseStat;
  int effort;
  String name;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.name,
  });
}

extension PokemonExtension on Pokemon {
  SimplePokemon get toSimplePokemon {
    return SimplePokemon(
      id: id,
      name: name,
      url: 'https://pokeapi.co/api/v2/pokemon/$id/',
    );
  }
}
