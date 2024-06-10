import 'package:flutter/material.dart';
import 'package:pokedex_clean/core/utils/utils.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';

class BadgeMoveWidget extends StatelessWidget {
  final MoveElement move;
  const BadgeMoveWidget({
    super.key,
    required this.move,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(move.move.name.capitalize(),
            style: const TextStyle(fontSize: 19)),
      ),
    );
  }
}
