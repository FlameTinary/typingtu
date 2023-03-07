import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:typingtu/utils/picture.dart';

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
  Uint8List? imageBytes;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  void widgetToImage(BuildContext context) async {
    screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((capturedImage) async {
      setState(() {
        imageBytes = capturedImage;
      });
      TYPicture().saveImage(imageBytes);
    }).catchError((onError) {
      debugPrint(onError);
    });
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
