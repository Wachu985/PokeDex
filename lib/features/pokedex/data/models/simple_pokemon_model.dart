import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:pokedex_clean/features/pokedex/domain/entities/simple_pokemon.dart';
part 'simple_pokemon_model.g.dart';

@collection
class SimplePokemonModel {
  final Id id;
  final String name;
  final String url;

  SimplePokemonModel({required this.id, required this.name, required this.url});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'url': url});

    return result;
  }

  factory SimplePokemonModel.fromMap(Map<String, dynamic> map) {
    return SimplePokemonModel(
      id: int.parse(
          map['url']?.toString().split('/').reversed.toList()[1] ?? '0'),
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SimplePokemonModel.fromJson(String source) =>
      SimplePokemonModel.fromMap(json.decode(source));
}

extension SimplePokemonModelExtension on SimplePokemonModel {
  SimplePokemon get toSimplePokemon {
    return SimplePokemon(
      id: id,
      name: name,
      url: url,
    );
  }
}
