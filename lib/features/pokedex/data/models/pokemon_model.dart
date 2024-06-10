import '../../domain/entities/entities.dart';

class PokemonModel {
  int baseExperience;
  int height;
  int id;
  List<MoveElementModel> moves;
  String name;
  SpritesModel sprites;
  List<StatModel> stats;
  int weight;

  PokemonModel({
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.moves,
    required this.name,
    required this.sprites,
    required this.stats,
    required this.weight,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        moves: List<MoveElementModel>.from(
            json["moves"].map((x) => MoveElementModel.fromJson(x))),
        name: json["name"],
        sprites: SpritesModel.fromJson(json["sprites"]),
        stats: List<StatModel>.from(
            json["stats"].map((x) => StatModel.fromJson(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "base_experience": baseExperience,
        "height": height,
        "id": id,
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "name": name,
        "sprites": sprites.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "weight": weight,
      };
}

class MoveElementModel {
  MoveMoveModel move;

  MoveElementModel({
    required this.move,
  });

  factory MoveElementModel.fromJson(Map<String, dynamic> json) =>
      MoveElementModel(
        move: MoveMoveModel.fromJson(json["move"]),
      );

  Map<String, dynamic> toJson() => {
        "move": move.toJson(),
      };
}

class MoveMoveModel {
  String name;
  String url;

  MoveMoveModel({
    required this.name,
    required this.url,
  });

  factory MoveMoveModel.fromJson(Map<String, dynamic> json) => MoveMoveModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class SpritesModel {
  String backDefault;
  dynamic backFemale;
  String backShiny;
  dynamic backShinyFemale;
  String frontDefault;
  dynamic frontFemale;
  String frontShiny;
  dynamic frontShinyFemale;

  SpritesModel({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  factory SpritesModel.fromJson(Map<String, dynamic> json) => SpritesModel(
        backDefault: json["back_default"],
        backFemale: json["back_female"],
        backShiny: json["back_shiny"],
        backShinyFemale: json["back_shiny_female"],
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}

class StatModel {
  int baseStat;
  int effort;
  String name;

  StatModel({
    required this.baseStat,
    required this.effort,
    required this.name,
  });

  factory StatModel.fromJson(Map<String, dynamic> json) => StatModel(
        baseStat: json["base_stat"],
        effort: json["effort"],
        name: json["stat"]['name'],
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "name": name,
      };
}

extension StatModelExtension on StatModel {
  Stat get toStat => Stat(baseStat: baseStat, effort: effort, name: name);
}

extension SpritesModelExtension on SpritesModel {
  Sprites get toSprites => Sprites(
        backDefault: backDefault,
        backFemale: backFemale,
        backShiny: backShiny,
        backShinyFemale: backShinyFemale,
        frontDefault: frontDefault,
        frontFemale: frontFemale,
        frontShiny: frontShiny,
        frontShinyFemale: frontShinyFemale,
      );
}

extension MoveMoveModelExtension on MoveMoveModel {
  MoveMove get toMoveMove => MoveMove(name: name, url: url);
}

extension MoveElementModelExtension on MoveElementModel {
  MoveElement get toMoveElement => MoveElement(move: move.toMoveMove);
}

extension PokemonModelExtension on PokemonModel {
  Pokemon get toPokemon => Pokemon(
        baseExperience: baseExperience,
        height: height,
        id: id,
        moves: List<MoveElement>.from(moves.map((x) => x.toMoveElement)),
        name: name,
        sprites: sprites.toSprites,
        stats: List<Stat>.from(stats.map((x) => x.toStat)),
        weight: weight,
      );
}
