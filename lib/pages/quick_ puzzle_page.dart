import 'package:flutter/material.dart';
import 'package:typingtu/pages/select_picture_page.dart';

class TYQuickPuzzlePage extends StatefulWidget {
  const TYQuickPuzzlePage({super.key});

  @override
  State<TYQuickPuzzlePage> createState() => _TYQuickPuzzlePageState();
}

class _TYQuickPuzzlePageState extends State<TYQuickPuzzlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('快速拼图'),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: const Text('单图九宫格布局'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TYSelectPicturePage(),
                  ),
                );
              },
            );
          }),
    );
  }
}
