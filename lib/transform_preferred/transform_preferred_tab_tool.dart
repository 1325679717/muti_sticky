import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muti_sticky/transform_preferred/transform_preferred_size.dart';

class TransformPreferredTabTool {
  final TabController? tabController;
  final ScrollController? controller;
  final int? index;
  final GlobalKey<TransformState>? transformKey;

  bool isCurrentTab() => tabController?.index == index;

  TransformPreferredTabTool.prepared({this.transformKey, this.controller, this.index, this.tabController}) {
    tabController?.addListener(() {
      if (!isCurrentTab()) {
        return;
      }
      _jumpTo();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpTo();
    });
    controller?.addListener(() {
      _setHeight();
    });
  }

  void _setHeight() {
    TransformPreferredSizeState? state = TransformPreferredSize.preferredSizeKey.currentState;
    state?.updateOffset(controller?.offset ?? 0);
    double maxHeight = state?.maxHeight ?? 0;
    double transformY = maxHeight - max(maxHeight - (controller?.offset ?? 0), (state?.minHeight ?? 0));
    transformKey?.currentState?.setHeight(transformY);
  }

  void _jumpTo() {
    TransformPreferredSizeState? state = TransformPreferredSize.preferredSizeKey.currentState;
    if (controller?.hasClients == true && controller?.position.activity?.isScrolling == false) {
      controller?.jumpTo(state?.transformY ?? 0);
      transformKey?.currentState?.setHeight(state?.transformY ?? 0);
    }
  }
}

class TransformPlaceHolderContainer extends StatefulWidget {
  const TransformPlaceHolderContainer({super.key});

  @override
  State<StatefulWidget> createState() {
    return TransformState();
  }
}

class TransformState extends State<TransformPlaceHolderContainer> {
  double _transformH = 0;

  void setHeight(double h) {
    setState(() {
      _transformH = h;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: _transformH);
  }
}
