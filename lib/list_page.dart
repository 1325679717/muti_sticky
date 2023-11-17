import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muti_sticky/sliver_header_delegate.dart';
import 'package:muti_sticky/transform_preferred/transform_preferred_tab_tool.dart';

class ListPage extends StatefulWidget {
  final TabController? tabController;
  final int? index;
  const ListPage({super.key, required this.index, this.tabController});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final GlobalKey<TransformState> transformKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    TransformPreferredTabTool.prepared(
        tabController: widget.tabController,
        controller: scrollController,
        index: widget.index,
        transformKey: transformKey);
  }
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: TransformPlaceHolderContainer(key: transformKey),
          ),
          SliverToBoxAdapter(
              child: Container(
            height: 50,
            child: Center(
              child: Text("header"),
            ),
          )),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
              parentContext: context,
              builder: (_, double shrinkOffset, __) {
                return Container(color: Colors.white, padding: EdgeInsets.only(top: 12), child: Center(child: Text("StickHeader"),));
              },
              fixHeight: 90,
            ),
          )
        ];
      },
      body: SafeArea(
          bottom: true,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
            child: Container(
              color: Colors.white,
              child: ListView.builder(itemBuilder: (_, i) {
                return Container(
                  color: i % 2 == 0 ? Colors.green : Colors.blue,
                  height: 50,
                  child: Text("item$i"),
                );
              }),
            ),
          )),
    );
  }
}
