import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:typingtu/utils/picture.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String? _picturePath;
  late TYPicture picture;

  @override
  void initState() {
    super.initState();
    picture = TYPicture();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _picturePath != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              clipBehavior: Clip.antiAlias, // 裁剪
              child: PhotoView(
                enablePanAlways: true, // 允许拖动
                enableRotation: true, // 允许旋转
                imageProvider: FileImage(File(_picturePath!)),
              ),
            )
          : GestureDetector(
              onTap: () {
                try {
                  picture.pickImage(context).then((value) {
                    debugPrint(value?.first ?? 'null');
                    setState(() {
                      _picturePath = value?.first;
                    });
                  });
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: Container(
                color: Colors.grey,
                child: const Icon(Icons.add, size: 50),
              ),
            ),
    );
  }
}
