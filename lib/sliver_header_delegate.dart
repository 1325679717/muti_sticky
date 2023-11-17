import 'package:flutter/material.dart';


class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  BuildContext parentContext;

  Widget Function(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) builder;

  double fixHeight;

  SliverHeaderDelegate({
    required this.parentContext,
    required this.builder,
    required this.fixHeight,
  });

  @override
  double get minExtent => fixHeight;

  @override
  double get maxExtent => fixHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: builder(context, shrinkOffset, overlapsContent),
    );
  }

  @override
  bool shouldRebuild(SliverHeaderDelegate oldDelegate) {
    return true;
  }
}
