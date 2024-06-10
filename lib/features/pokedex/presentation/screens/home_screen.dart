import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/features/pokedex/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/home/custom_app_bar.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/home/pokemon_card.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/home/sliver_custom_search.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/shared/background_color_widget.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/shared/error_custom_widget.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/shared/side_menu.dart';

import '../widgets/home/search_bar_custom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final TextEditingController searchController = TextEditingController();
    final state = context.watch<PokemonBloc>().state;
    if (state.isHomeSuccess || state.isHomeLoading) {
      return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        body: Stack(
          children: [
            const BackgroundColorWidget(
              alignment: Alignment.center,
              bgColor: Colors.amber,
            ),
            const BackgroundColorWidget(
              bottom: 250,
              right: 50,
              bgColor: Colors.blue,
            ),
            CustomScrollView(
              controller: context.read<PokemonBloc>().scrollController,
              slivers: [
                const CustomAppBar(),
                SliverPersistentHeader(
                  floating: true,
                  delegate: SliverCustomSearch(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: SearchBarCustom(
                        controller: searchController,
                        hintText: 'Buscar',
                        onPressed: (e) {
                          context
                              .read<PokemonBloc>()
                              .add(PokemonEvent.searchPokemonEvent(text: e));
                          searchController.clear();
                          context.go('/pokemon-detail');
                        },
                        onSubmitted: (e) {
                          context
                              .read<PokemonBloc>()
                              .add(PokemonEvent.searchPokemonEvent(text: e));
                          searchController.clear();
                          context.go('/pokemon-detail');
                        },
                      ),
                    ),
                    maxheight: 55,
                    minheight: 55,
                  ),
                  pinned: true,
                ),
                state.isHomeLoading
                    ? const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : SliverGrid.builder(
                        itemBuilder: (context, index) => FadeIn(
                            child: PokemonCard(
                                pokemon: state.listPokemons[index])),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: state.listPokemons.length,
                      ),
              ],
            ),
          ],
        ),
      );
    } else if (state.isHomeError) {
      return Scaffold(
        body: Center(
          child: ErrorCustomWidget(
            text: state.errorText,
            onPressed: () =>
                context.read<PokemonBloc>().add(PokemonEvent.getAllPokemons()),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
