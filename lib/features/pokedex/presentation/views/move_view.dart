import 'package:flutter/material.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';
import 'package:pokedex_clean/features/pokedex/presentation/widgets/detail/badge_move_widget.dart';

class MoveView extends StatelessWidget {
  final Pokemon pokemon;
  const MoveView({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 270,
          width: size.width,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.grey.withOpacity(0.2),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                ...pokemon.moves
                    .take(8)
                    .map((move) => BadgeMoveWidget(move: move)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
