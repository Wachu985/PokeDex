import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/core/utils/utils.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';
import 'package:pokedex_clean/features/pokedex/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_clean/features/pokedex/presentation/views/move_view.dart';
import 'package:pokedex_clean/features/pokedex/presentation/views/stats_view.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/widgets.dart';

class DetailPokemon extends StatelessWidget {
  const DetailPokemon({super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PokemonBloc>().state;
    final pokemon = context.watch<PokemonBloc>().state.selectedPokemon;

    if (state.isDetailSuccess || state.isDetailLoading) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: state.isDetailLoading
                ? const Text('')
                : Text(state.selectedPokemon?.name.capitalize() ?? ''),
            actions: [
              FutureBuilder<bool>(
                  future:
                      context.read<PokemonBloc>().isFavorite(pokemon?.id ?? 0),
                  builder: (context, snapshot) {
                    return IconButton(
                      onPressed: () => context.read<PokemonBloc>().add(
                          PokemonEvent.toogleFavorite(
                              pokemon: pokemon!.toSimplePokemon)),
                      icon: Icon(
                        snapshot.data ?? false
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color:
                            snapshot.data ?? false ? Colors.red : Colors.white,
                      ),
                    );
                  }),
            ],
          ),
          body: Stack(
            children: [
              const BackgroundColorWidget(
                bgColor: Colors.amber,
                top: 40,
                right: 70,
                width: 300,
                spreadRadius: 0,
                height: 300,
                blurRadius: 300,
              ),
              const BackgroundColorWidget(
                bgColor: Colors.blueAccent,
                bottom: 110,
                right: 0,
                width: 200,
                spreadRadius: 0,
                height: 200,
                blurRadius: 200,
              ),
              const BackgroundColorWidget(
                bgColor: Colors.deepPurple,
                bottom: 110,
                left: 0,
                width: 200,
                height: 200,
                blurRadius: 200,
                spreadRadius: 0,
              ),
              state.isDetailLoading
                  ? const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Column(
                      children: [
                        ElasticIn(
                            child: PokemonPrincipalCard(pokemon: pokemon)),
                        CenterDataPokemon(pokemon: pokemon),
                        FadeIn(
                          child: const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: TabBarWidget(),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SlideInUp(
                                child: StatsView(pokemon: pokemon!),
                              ),
                              SlideInUp(
                                child: MoveView(pokemon: pokemon),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      );
    } else if (state.isDetailError) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: ErrorCustomWidget(
          text: state.errorText,
          onPressed: () => context.pop(),
          buttomText: 'Volver a Atras',
        )),
      );
    } else {
      return Container();
    }
  }
}
