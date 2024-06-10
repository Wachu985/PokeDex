import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorCustomWidget extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final String buttomText;
  const ErrorCustomWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.buttomText = 'Reintentar',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          height: 250,
          "assets/undraw_warning_re_eoyh.svg",
          semanticsLabel: 'Acme Logo',
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(elevation: 5),
            child: Text(buttomText, style: const TextStyle(fontSize: 18)),
          ),
        )
      ],
    );
  }
}
