import 'package:flutter/material.dart';

class BackgroundColorWidget extends StatelessWidget {
  final Alignment? alignment;
  final Color bgColor;
  final double? bottom;
  final double? left;
  final double? top;
  final double? right;
  final double height;
  final double width;
  final double spreadRadius;
  final double blurRadius;
  const BackgroundColorWidget({
    super.key,
    this.alignment,
    required this.bgColor,
    this.bottom,
    this.left,
    this.top,
    this.right,
    this.width = 50,
    this.height = 50,
    this.spreadRadius = 30,
    this.blurRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(
                  color: bgColor,
                  blurRadius: blurRadius,
                  blurStyle: BlurStyle.normal,
                  spreadRadius: spreadRadius,
                )
              ]),
            ),
          )
        : Positioned(
            bottom: bottom,
            left: left,
            top: top,
            right: right,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(
                    color: bgColor,
                    blurRadius: blurRadius,
                    spreadRadius: spreadRadius)
              ]),
            ));
  }
}
