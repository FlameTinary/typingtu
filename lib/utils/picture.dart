import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'permission.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class TYPicture {
  // 获取单张图片的方法
  Future<List<String>?> pickImage(context) async {
    final List<AssetEntity>? entitys = await AssetPicker.pickAssets(context,pickerConfig: const AssetPickerConfig(
      maxAssets: 1,
    ));
    if (entitys == null) return null;

    List<String> chooseImagesPath = [];
    //遍历
    for (var entity in entitys) {
      File? imgFile = await entity.file;
      if (imgFile != null) chooseImagesPath.add(imgFile.path);
    }
    debugPrint('选择照片路径:$chooseImagesPath');
    return chooseImagesPath;
  }

  // 获取多张图片的方法
  Future<List<String>?> pickMultiImage(context) async {
    final List<AssetEntity>? entitys = await AssetPicker.pickAssets(context);
    if (entitys == null) return null;

    List<String> chooseImagesPath = [];
    //遍历
    for (var entity in entitys) {
      File? imgFile = await entity.file;
      if (imgFile != null) chooseImagesPath.add(imgFile.path);
    }
    debugPrint('选择照片路径:$chooseImagesPath');
    return chooseImagesPath;
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
