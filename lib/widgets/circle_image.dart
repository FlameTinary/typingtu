import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// 绘制一个圆形widget


class CircleImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  CircleImage({required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: CircleImagePainter(imageUrl),
    );
  }
}

class CircleImagePainter extends CustomPainter {
  final String imageUrl;

  CircleImagePainter(this.imageUrl);

  @override
  void paint(Canvas canvas, Size size) async {
    // 加载图片
    ui.Image image = await loadImage(imageUrl);

    // 计算图片的中心点和半径
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;

    // 绘制圆形
    Path path = Path()..addOval(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius));
    canvas.clipPath(path);

    // 绘制图片
    Rect src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    Rect dst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, src, dst, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Future<ui.Image> loadImage(String imageUrl) async {
    ImageStream stream = NetworkImage(imageUrl).resolve(ImageConfiguration.empty);
    Completer<ui.Image> completer = Completer<ui.Image>();
    stream.addListener(ImageStreamListener((ImageInfo imageInfo, bool _) {
      completer.complete(imageInfo.image);
    }));
    return completer.future;
  }
}