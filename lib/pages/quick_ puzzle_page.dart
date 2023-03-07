import 'package:flutter/material.dart';

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
              title: Text('单图九宫格布局'),
              onTap: () {
                debugPrint('$index');
              },
            );
          }),
    );
  }
}
