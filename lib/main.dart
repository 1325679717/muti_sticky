import 'package:flutter/material.dart';
import 'package:muti_sticky/list_page.dart';
import 'package:muti_sticky/transform_preferred/transform_preferred_size.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController? controller;
  List<String> titleTabList = [
    "tab1",
    "tab2",
    "tab3",
    "tab4",
    "tab5",
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TransformPreferredSize(
          offsetBuild: (double offset) {
            return AppBar(
              title: Container(
                  height: 30,
                  child: Stack(
                children: [Positioned(top: -offset +3, child: Text(widget.title))],
              )),
              bottom: TabBar(
                tabs: titleTabList.map((e) => Text(e)).toList(),
                controller: controller,
              ),
            );
          },
          maxHeight: 135,
          minHeight: 100,
        ),
        body: Container(
          child: TabBarView(
            children: [
              ListPage(index: 0, tabController: controller),
              ListPage(index: 1, tabController: controller),
              ListPage(index: 2, tabController: controller),
              ListPage(index: 3, tabController: controller),
              ListPage(index: 4, tabController: controller)
            ],
            controller: controller,
          ),
        ));
  }
}
