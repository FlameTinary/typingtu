import 'package:flutter/material.dart';
import 'package:typingtu/main_page.dart';

class TYApp extends StatelessWidget {
  const TYApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '拼图',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const TYMainPage(),
    );
  }
}
