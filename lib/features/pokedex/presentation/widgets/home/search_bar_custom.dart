import 'package:flutter/material.dart';

class SearchBarCustom extends StatelessWidget {
  // final double minExtent;
  // final double maxExtent;
  final TextEditingController controller;
  final String hintText;
  final Function(String value) onSubmitted;
  final Function(String value) onPressed;

  const SearchBarCustom(
      {super.key,
      // required this.minExtent,
      // required this.maxExtent,
      required this.controller,
      required this.onPressed,
      required this.hintText,
      required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(top: 5),
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => onPressed(controller.value.text),
            icon: Icon(
              Icons.search_rounded,
              color: Colors.grey[200],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 13.5),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  // @override
  // bool shouldRebuild(SearchBarCustom oldDelegate) {
  //   return oldDelegate.minExtent != minExtent ||
  //       oldDelegate.maxExtent != maxExtent;
  // }
}
