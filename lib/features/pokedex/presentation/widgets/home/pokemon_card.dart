import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex_clean/core/utils/utils.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/shared/gradient_box.dart';

import '../../bloc/pokemon_bloc.dart';

class PokemonCard extends StatelessWidget {
  final PaletteGenerator? paletteGenerator;
  final Color defaultColor = Colors.blue;
  final SimplePokemon pokemon;
  final String urlPush;
  const PokemonCard(
      {super.key,
      required this.pokemon,
      this.paletteGenerator,
      this.urlPush = '/pokemon-detail'});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color>(
        future: getColorPalet(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png'),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              context
                  .read<PokemonBloc>()
                  .add(PokemonEvent.getOnePokemon(pokemonId: pokemon.id));
              context.go(urlPush);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: snapshot.data,
              margin: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                        imageUrl:
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${pokemon.id}.png'),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: const GradientBox(
                      colors: [Colors.black26, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.0, 0.5],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(pokemon.name.capitalize(),
                              style: const TextStyle(fontSize: 23)),
                          const Icon(Icons.arrow_circle_right_outlined),
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder<bool>(
                      future:
                          context.read<PokemonBloc>().isFavorite(pokemon.id),
                      builder: (context, snapshot) {
                        return IconButton(
                          onPressed: () => context.read<PokemonBloc>().add(
                              PokemonEvent.toogleFavorite(pokemon: pokemon)),
                          icon: Icon(
                            snapshot.data ?? false
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline_rounded,
                            color: snapshot.data ?? false
                                ? Colors.red
                                : Colors.white,
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }
}
