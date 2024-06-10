import 'package:flutter/material.dart';

class SimplePokemon {
  final int id;
  final String name;
  final String url;
  final Color? color;

  SimplePokemon(
      {required this.id, required this.name, required this.url, this.color});
}
