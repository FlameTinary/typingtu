import 'package:flutter/material.dart';

class TYTemplatePuzzlePage extends StatefulWidget {
  const TYTemplatePuzzlePage({super.key});

  @override
  State<TYTemplatePuzzlePage> createState() => _TYTemplatePuzzlePageState();
}

class _TYTemplatePuzzlePageState extends State<TYTemplatePuzzlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('模板拼图'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}