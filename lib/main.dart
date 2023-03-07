import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:typingtu/utils/picture.dart';
import 'package:typingtu/widgets/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

void main() {
  AssetPicker.registerObserve();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '拼图',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '首页'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? imageBytes;
  ScreenshotController screenshotController = ScreenshotController();

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            child: Screenshot(
              controller: screenshotController,
              child: const Center(
                child: ImagePickerWidget(),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              TYPicture().pickImage(context);
            },
            child: const Text('快速拼图'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widgetToImage(context);
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
