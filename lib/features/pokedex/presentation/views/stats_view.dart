import 'package:flutter/material.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/detail/card_stat_widget.dart';

class StatsView extends StatelessWidget {
  const StatsView({
    super.key,
    required this.pokemon,
  });

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 270,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.grey.withOpacity(0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...pokemon!.stats.map((stat) => CardStatWidget(stat: stat)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
