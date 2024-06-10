import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/detail/element_widget.dart';

class CenterDataPokemon extends StatelessWidget {
  const CenterDataPokemon({
    super.key,
    required this.pokemon,
  });

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeInLeft(
              delay: const Duration(milliseconds: 1000),
              child: ElementWidget(
                  title: '${pokemon!.height / 10} M', subtitle: 'Height')),
          FadeInDown(
            delay: const Duration(milliseconds: 500),
            child: CircleAvatar(
              maxRadius: 30,
              minRadius: 30,
              backgroundColor: Colors.amber[800],
              // child: Icon(Icons.storm_rounded),
              backgroundImage: const AssetImage('assets/pngwing.com.png'),
            ),
          ),
          FadeInRight(
            delay: const Duration(milliseconds: 1000),
            child: ElementWidget(
              title: '${pokemon!.weight * 0.1} KG',
              subtitle: 'Weight',
            ),
          )
        ],
      ),
    );
  }
}
