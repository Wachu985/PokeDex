import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';

class PokemonPrincipalCard extends StatelessWidget {
  const PokemonPrincipalCard({
    super.key,
    required this.pokemon,
  });

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: size.height * 0.33,
        width: size.width * 0.8,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.grey.withOpacity(0.3),
          child: CachedNetworkImage(
            imageUrl:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${pokemon?.id}.png',
          ),
        ),
      ),
    );
  }
}
