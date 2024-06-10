import 'package:flutter/material.dart';

class ElementWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const ElementWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 13),
        )
      ],
    );
  }
}
