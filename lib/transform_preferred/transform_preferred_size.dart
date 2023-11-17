import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

typedef OffsetBuild = Widget Function(double offset);


class TransformPreferredSize extends StatefulWidget implements PreferredSizeWidget {
  static final GlobalKey<TransformPreferredSizeState> preferredSizeKey = GlobalKey();
  final OffsetBuild offsetBuild;
  final double maxHeight;
  final double minHeight;
  final String? path;
  final ValueNotifier<double> offsetNotifier = ValueNotifier(0);

  final bool isShowBackground;

  TransformPreferredSize({
    required this.offsetBuild,
    required this.maxHeight,
    required this.minHeight,
    this.path,
    this.isShowBackground  = true,
  }) : super(key: preferredSizeKey);

  @override
  TransformPreferredSizeState createState() => TransformPreferredSizeState();

  @override
  Size get preferredSize => Size.fromHeight(maxHeight);
}

class TransformPreferredSizeState extends State<TransformPreferredSize> {
  late double _currentHeight;
  double get transformY => widget.preferredSize.height - _currentHeight;
  double get maxHeight => widget.maxHeight;
  double get minHeight => widget.minHeight;
  @override
  void initState() {
    super.initState();
    _currentHeight = maxHeight;
  }

 void updateOffset(double offset){
    widget.offsetNotifier.value = offset;
 }
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<double>(
      builder: (context, value, Widget? child) {
        double offset = min(value, maxHeight - minHeight);
        _currentHeight = max(maxHeight -value, minHeight);
        return SizedBox.fromSize(
          size: Size.fromHeight(_currentHeight),
          child: Stack(children: [
            Positioned(
              left: 0,
              right: 0,
              top: -offset,
              child: Builder(
                builder: (context) {
                  return SizedBox(
                    height: widget.preferredSize.height,
                    child: widget.path != null && widget.path != "" && widget.isShowBackground == true
                        ? Image.asset(
                      widget.path ?? "",
                      fit: BoxFit.fill,
                    )
                        : const ColoredBox(color: Colors.white),
                  );
                }
              ),
            ),
            widget.offsetBuild(offset),
          ]),
        );
      }, valueListenable: widget.offsetNotifier,
    );
  }
}
