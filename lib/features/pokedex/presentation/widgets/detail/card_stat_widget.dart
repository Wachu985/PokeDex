import 'package:flutter/material.dart';
import 'package:pokedex_clean/core/utils/utils.dart';
import 'package:pokedex_clean/features/pokedex/domain/domain.dart';

class CardStatWidget extends StatelessWidget {
  final Stat stat;
  const CardStatWidget({
    super.key,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(stat.name.capitalize(), style: const TextStyle(fontSize: 17)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '${stat.baseStat}',
              style: const TextStyle(fontSize: 18, color: Colors.amber),
            ),
          ),
          SizedBox(
            width: 173,
            child: LinearProgressIndicator(
              value: stat.baseStat * 0.01,
              backgroundColor: Colors.grey,
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
              minHeight: 13,
            ),
          )
        ],
      ),
    );
  }
}
