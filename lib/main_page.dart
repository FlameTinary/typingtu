

import 'package:flutter/material.dart';

import 'package:typingtu/pages/quick_ puzzle_page.dart';
import 'package:typingtu/pages/template_puzzle_page.dart';

class TYMainPage extends StatefulWidget {
  const TYMainPage({super.key});

  @override
  State<TYMainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TYMainPage> {

  // 底部导航栏选中index
  int _selectedIndex = 0;

  // 首页数组
  final List _pages = [const TYQuickPuzzlePage(), const TYTemplatePuzzlePage()];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // 快速拼图item
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '快速拼图',
          ),
          // 主题模板item
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '主题模版',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
