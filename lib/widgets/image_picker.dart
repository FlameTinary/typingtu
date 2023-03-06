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
  XFile? _picture;
  late TYPicture picture;

  @override
  void initState() {
    super.initState();
    picture = TYPicture();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: _picture != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              clipBehavior: Clip.antiAlias, // 裁剪
              child: PhotoView(
                enablePanAlways: true, // 允许拖动
                imageProvider: FileImage(File(_picture!.path)),
              ),
            )
          : GestureDetector(
              onTap: () {
                try {
                  picture.pickImage().then((value) {
                    debugPrint(value?.path);
                    setState(() {
                      _picture = value;
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
