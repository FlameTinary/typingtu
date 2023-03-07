import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:typingtu/widgets/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:typingtu/utils/picture.dart';

class TYSelectPicturePage extends StatefulWidget {
  const TYSelectPicturePage({super.key});

  @override
  State<TYSelectPicturePage> createState() => _TYSelectPicturePageState();
}

class _TYSelectPicturePageState extends State<TYSelectPicturePage> {
  // 选择的图片数据
  Uint8List? imageBytes;
  // 截图控制器
  ScreenshotController screenshotController = ScreenshotController();

  // 拼图比例
  int ratio = 0; // 0: 1:1 1: 3:4 2: 9:16

  // 截图
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

  // 计算图片的宽高
  double calculateImageWidth(double screenW) {
    double imageW = screenW * 0.8;
    double imageH = screenW * 0.8;
    switch (ratio) {
      case 0:
        imageH = screenW * 0.8;
        break;
      case 1:
        imageH = screenW * 0.8 * 4 / 3;
        break;
      case 2:
        imageH = screenW * 0.8 * 16 / 9;
        break;
    }
    return imageH;
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    double screenW = MediaQuery.of(context).size.width;
    // 获取屏幕高度
    double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('选择图片'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Screenshot(
              controller: screenshotController,
              child: SizedBox(
                  width: screenW * 0.8,
                  height: calculateImageWidth(screenW),
                  child: const ImagePickerWidget()),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '请选择你要拼图的比例：',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    debugPrint('选择1:1的尺寸');
                    setState(() {
                      ratio = 0;
                    });
                  },
                  child: const Text('1:1'),
                ),
                TextButton(
                  onPressed: () {
                    debugPrint('选择3:4的尺寸');
                    setState(() {
                      ratio = 1;
                    });
                  },
                  child: const Text('3:4'),
                ),
                TextButton(
                  onPressed: () {
                    debugPrint('选择16:9的尺寸');
                    setState(() {
                      ratio = 2;
                    });
                  },
                  child: const Text('16:9'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widgetToImage(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
