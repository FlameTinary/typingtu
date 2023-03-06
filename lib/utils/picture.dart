import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'permission.dart';

class TYPicture {

  final ImagePicker _picker = ImagePicker();

  // 获取单张图片的方法
  Future<XFile?> pickImage() async {
    // 使用image_picker插件打开相册
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  // 获取多张图片的方法
  Future<List<XFile>> pickMultiImage() async {
    // 使用image_picker插件打开相册
    return await _picker.pickMultiImage();
  }

  // 使用image_gallery_saver插件可以将图片保存到手机相册
  FutureOr<dynamic> saveImage(Uint8List? imageBytes) async {
    if (await TYPermission.requestPermission() && imageBytes != null) {
      final result = await ImageGallerySaver.saveImage(imageBytes!);
      debugPrint('--- $result');
      return result;
    }
  }

}
