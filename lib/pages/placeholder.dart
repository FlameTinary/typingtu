// 使用photo_manager实现自定义的图片选择器
//
// Path: lib/utils/picture.dart
// Compare this snippet from messages.g.dart:
// import 'package:flutter/services.dart';
//
// enum SourceCamera {
//   rear,
//   front,
// }
//
// enum SourceType {
//   camera,
//   gallery,
// }
//
// class MaxSize {
//   MaxSize({
//     this.width,
//     this.height,
//   });
//
//   double? width;
//   double? height;
//
//   Object encode() {
//     final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
//     pigeonMap['width'] = width;
//     pigeonMap['height'] = height;
//     return pigeonMap;
//   }
//
//   static MaxSize decode(Object message) {
//     final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
//     return MaxSize(
//       width: pigeonMap['width'] as double?,
//       height: pigeonMap['height'] as double?,
//     );
//   }
// }
//
// class SourceSpecification {  
//   SourceSpecification({
//     required this.type,
//     this.camera,
//   });
//
//   SourceType type;
//   SourceCamera? camera;
//
//   Object encode() {
//     final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
//     pigeonMap['type'] = type.index;
//     pigeonMap['camera'] = camera?.index;
//     return pigeonMap;
//   }
//
//   static SourceSpecification decode(Object message) {
//     final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
//     return SourceSpecification(
//       type: SourceType.values[pigeonMap['type']! as int],
//       camera: pigeonMap['camera'] != null
//           ? SourceCamera.values[pigeonMap['camera']! as int]
//           : null,
//     );
//   }
// }
//
// class XFile {
//   XFile({
//     required this.path,
//     this.name,
//     this.length,
//     this.modified,
//   });
//
//   String path;
//   String? name;
//   int? length;
//   DateTime? modified;
//
//   Object encode() {
//     final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
//     pigeonMap['path'] = path;
//     pigeonMap['name'] = name;
//     pigeonMap['length'] = length;
//     pigeonMap['modified'] = modified?.millisecondsSinceEpoch;
//     return pigeonMap;
//   }
//
//   static XFile decode(Object message) {
//     final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
//     return XFile(
//       path: pigeonMap['path']! as String,
//       name: pigeonMap['name'] as String?,
//       length: pigeonMap['length'] as int?,
//       modified: pigeonMap['modified'] != null
//           ? DateTime.fromMillisecondsSinceEpoch(pigeonMap['modified']! as int)
//           : null,
//     );
//   }
// }
//
// class XFileList {
//   XFileList({
//     required this.files,
//   });
//
//   List<XFile> files;
//

//   Object encode() {
//     final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
//     pigeonMap['files'] = files.map((XFile x) => x.encode()).toList();
//     return pigeonMap;
//   }
//
//   static XFileList decode(Object message) {
//     final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
//     return XFileList(
//       files: pigeonMap['files']!
//           .map((Object x) => XFile.decode(x))
//           .toList()
//           .cast<XFile>(),
//     );
//   }
// }
//
// class ImagePickerApi {
//   Future<XFileList> pickImages({
//     required MaxSize? maxSize,
//     required SourceSpecification source,
//   }) async {
//     final Object reply = await _channel.invokeMethod('pickImages', <String, Object?>{
//       'maxSize': maxSize?.encode(),
//       'source': source.encode(),
//     });
//     return XFileList.decode(reply);
//   }
//
//   static const MethodChannel _channel = MethodChannel('dev.flutter.pigeon.ImagePickerApi');
// }
//
// class ImagePickerApiSetup {
//   static void setup(ImagePickerApi api) {
//     {
//       const BasicMessageChannel<Object?> channel =
//           BasicMessageChannel<Object?>('dev.flutter.pigeon.ImagePickerApi.pickImages', StandardMessageCodec());
//       channel.setMessageHandler((Object? message) async {
//         final Map<Object?, Object?> args = message as Map<Object?, Object?>;
//         final MaxSize? arg_maxSize = args['maxSize'] != null ? MaxSize.decode(args['maxSize']!) : null;
//         final SourceSpecification arg_source = SourceSpecification.decode(args['source']!);
//         final XFileList output = await api.pickImages(maxSize: arg_maxSize, source: arg_source);
//         return output.encode();
//       });
//     }
//   }
// }
//
// void main() {
//   ImagePickerApiSetup.setup(ImagePickerApi());
// }