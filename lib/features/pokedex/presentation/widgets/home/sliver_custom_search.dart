import 'package:flutter/material.dart';

class SliverCustomSearch extends SliverPersistentHeaderDelegate {
  double minheight;
  double maxheight;
  Widget child;

  SliverCustomSearch(
      {required this.child, required this.maxheight, required this.minheight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => (minheight > maxheight) ? minheight : maxheight;

  @override
  double get minExtent => (minheight < maxheight) ? minheight : maxheight;

  @override
  bool shouldRebuild(covariant SliverCustomSearch oldDelegate) {
    return maxheight != oldDelegate.maxheight ||
        minheight != oldDelegate.minheight ||
        child != oldDelegate.child;
  }
}
