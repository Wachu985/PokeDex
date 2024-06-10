import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/features/pokedex/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/home/pokemon_card.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/shared/error_custom_widget.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/shared/side_menu.dart';

class FavoritesPokemon extends StatefulWidget {
  const FavoritesPokemon({super.key});

  @override
  State<FavoritesPokemon> createState() => _FavoritesPokemonState();
}

class _FavoritesPokemonState extends State<FavoritesPokemon> {
  @override
  void initState() {
    context.read<PokemonBloc>().add(PokemonEvent.getFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PokemonBloc>().state;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    if (state.isFavoriteSuccess || state.isFavoriteLoading) {
      return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text('Pokemons Favoritos'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => context
                    .read<PokemonBloc>()
                    .add(PokemonEvent.getFavoritesEvent()),
                icon: const Icon(Icons.refresh_rounded))
          ],
        ),
        body: state.isFavoriteLoading
            ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
            : state.listFavorites.isEmpty
                ? Center(
                    child: ErrorCustomWidget(
                      text: 'No tiene pokemons favoritos.',
                      onPressed: () => context.go('/'),
                      buttomText: 'Agregar Favoritos',
                    ),
                  )
                : GridView.builder(
                    itemBuilder: (context, index) => FadeIn(
                      child: PokemonCard(
                        pokemon: state.listFavorites[index],
                        urlPush: '/favorites/pokemon-detail',
                      ),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.listFavorites.length,
                  ),
      );
    } else if (state.isFavoriteError) {
      return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        body: Center(
          child: ErrorCustomWidget(
            text: state.errorText,
            buttomText: 'Reintentar',
            onPressed: () => context
                .read<PokemonBloc>()
                .add(PokemonEvent.getFavoritesEvent()),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
