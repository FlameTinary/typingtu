

import 'package:flutter/material.dart';

import 'package:typingtu/pages/quick_ puzzle_page.dart';
import 'package:typingtu/pages/template_puzzle_page.dart';

class TYMainPage extends StatefulWidget {
  const TYMainPage({super.key});

  @override
  State<TYMainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TYMainPage> {
  int _selectedIndex = 0;
  final List _pages = [const TYQuickPuzzlePage(), const TYTemplatePuzzlePage()];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '快速拼图',
          ),
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
