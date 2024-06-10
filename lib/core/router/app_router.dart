import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/features/pokedex/presentation/screens/detail_pokemon.dart';
import 'package:pokedex_clean/features/pokedex/presentation/screens/favorites_pokemon.dart';
import 'package:pokedex_clean/features/pokedex/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'pokemon-detail',
            builder: (context, state) => const DetailPokemon(),
          )
        ]),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesPokemon(),
      routes: [
        GoRoute(
          path: 'pokemon-detail',
          builder: (context, state) => const DetailPokemon(),
        )
      ],
    )
  ],
);
