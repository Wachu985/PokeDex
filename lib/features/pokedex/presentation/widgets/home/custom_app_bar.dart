import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,

      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            onPressed: () => context.go('/about'),
            icon: const Icon(Icons.settings_rounded),
          ),
        )
      ],

      // backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: 2.5,
        title: Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Encuentra Tu Pokemon',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
