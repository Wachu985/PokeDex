import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      dividerColor: Colors.transparent,
      tabs: [
        Tab(
          child: Text(
            'Stats',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Tab(
          child: Text(
            'Moves',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
