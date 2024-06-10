import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_clean/core/router/app_router.dart';
import 'package:pokedex_clean/core/theme/app_theme.dart';
import 'package:pokedex_clean/features/pokedex/presentation/bloc/pokemon_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/inyection/dependency_inyection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInyection.init();
  runApp(BlocProvider(
    lazy: false,
    create: (context) => DependencyInyection.sl<PokemonBloc>()
      ..add(PokemonEvent.getAllPokemons())
      ..init(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PokeDex',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      builder: responsiveBuilder,
      theme: const AppTheme(
        darkMode: true,
      ).getTheme(),
    );
  }

  Widget responsiveBuilder(context, child) => ResponsiveBreakpoints.builder(
        child: Builder(
          builder: (context) {
            return MaxWidthBox(
              maxWidth: 1200,
              background: Container(color: const Color(0xFFF5F5F5)),
              child: ResponsiveScaledBox(
                width: ResponsiveValue<double?>(
                  context,
                  conditionalValues: [
                    const Condition.equals(name: MOBILE, value: 450),
                    const Condition.between(start: 800, end: 1100, value: 800),
                    const Condition.between(start: 1000, end: 1200, value: 700),
                  ],
                ).value,
                child: child!,
              ),
            );
          },
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      );
}
