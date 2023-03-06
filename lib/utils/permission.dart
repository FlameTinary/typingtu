import 'package:permission_handler/permission_handler.dart';

class TYPermission {
  // 使用permission_handler插件来请求权限
  static Future<bool> requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }
}