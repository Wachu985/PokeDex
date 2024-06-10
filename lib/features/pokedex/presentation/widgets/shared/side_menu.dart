import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/features/pokedex/presentation/bloc/pokemon_bloc.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final List<String> list = const ['/', '/favorites'];

  @override
  Widget build(BuildContext context) {
    int navDrawerIndex = context.watch<PokemonBloc>().state.navDrawler;
    final textStyles = Theme.of(context).textTheme;

    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          // final menuItem = appMenuItems[value];
          if (value <= 2) {
            context
                .read<PokemonBloc>()
                .add(PokemonEvent.changeDrawlerEvent(newDrawler: value));
            context.go(list[value]);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => list[value],
            //     ));
            widget.scaffoldKey.currentState?.closeDrawer();
          }
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text('Personal Pokedex',
                style: textStyles.titleLarge, textAlign: TextAlign.center),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.map_rounded),
            label: Text('Pokemons'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.favorite_rounded),
            label: Text('Pokemons Favoritos'),
          ),
        ]);
  }
}
