import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:typingtu/pages/select_picture_page.dart';
import 'package:typingtu/models/puzzle.dart';

/// 快速拼图列表页面

class TYQuickPuzzlePage extends StatefulWidget {
  const TYQuickPuzzlePage({super.key});

  @override
  State<TYQuickPuzzlePage> createState() => _TYQuickPuzzlePageState();
}

class _TYQuickPuzzlePageState extends State<TYQuickPuzzlePage> {
  // 列表数据
  List<PuzzleModel> _puzzles = [];

  // 加载本地json文件
  Future<String> _loadFromAssets() async {
    return await rootBundle.loadString('assets/data/puzzle.json');
  }

  // 解析json字符串
  _loadJson() async {
    String puzzleString = await _loadFromAssets();
    List<PuzzleModel> puzzles = puzzleModelFromJson(puzzleString);
    setState(() {
      _puzzles = puzzles;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  // 通过数据构建section
  List<Widget> buildSectionWithPuzzles(List<PuzzleModel> list) {
    List<Widget> widgets = [];
    for (PuzzleModel puzzle in list) {
      widgets.add(SliverPersistentHeader(
        delegate: SliverHeaderDelegate(
          builder: (context, shrinkOffset, overlapsContent) {
            return Container(
              color: Colors.red,
              height: 44,
              child: ListTile(
                title: Text(puzzle.count),
              ),
            );
          },
        ),
        pinned: false,
      ));
      for (Content content in puzzle.content) {
        widgets.add(SliverFixedExtentList(
          itemExtent: 44,
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: Image(
                  image: AssetImage(content.icon),
                  width: 20,
                  height: 20,
                ),
                title: Text(content.type),
              );
            },
            childCount: 1,
          ),
        ));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('快速拼图'),
      ),
      body: CustomScrollView(
        slivers: buildSectionWithPuzzles(_puzzles),
      ),
    );
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverHeaderDelegate({
    this.maxHeight = 44,
    this.minHeight = 44,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
