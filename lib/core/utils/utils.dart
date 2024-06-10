import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color> getColorPalet(url) async {
  final pallete =
      await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(url));
  return pallete.colors.first;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
