import 'package:flutter/material.dart';

class MyGuess extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('猜你喜欢', style: TextStyle(fontSize: 20)),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
