import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      elevation: 2.0,

      actions: [
        // TODO: Corregir Esto
        Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                'https://lh5.googleusercontent.com/proxy/dG_zKqcKHlrISWacq_2i-oW0_U7cmnMPq6nDX7TGVr_76KVva_nMr0SSnkpSBO0vzKRADGSDT2RmVGImjzaGxjO8CkjnGeVH6r-DeXe54D9eNxy5IsiuwS0Zzcr5wNVg7j83W0o5FMRfbQ'),
          ),
        )
      ],

      // backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
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
