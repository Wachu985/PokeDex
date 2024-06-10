import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  const GradientBox({
    super.key,
    required this.colors,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
  });
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: begin,
            end: end,
            stops: stops,
          ),
        ),
      ),
    );
  }
}
