import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<Uint8List> toQrImageData(String text) async {
  try {
    final image = await QrPainter(
      data: text,
      gapless: false,
      version: QrVersions.auto,
    ).toImage(300);
    final a = await image.toByteData(format: ImageByteFormat.png);
    return a.buffer.asUint8List();
  } catch (e) {
    throw e;
  }
}

abstract class QrCodeFile {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName) async {
    final savePath = await localPath;
    return File(savePath + "/$fileName");
  }

  static Future<File> _writeQrCode({String data, String fileName}) async {
    final file = await QrCodeFile._localFile(fileName);
    final content = await toQrImageData(data);

    file.writeAsBytes(content);
    return file;
  }

  static Future<File> _readContent(path) async {
    return File(path);
  }

  static Future<File> saveQrcode(String data) async {
    return await QrCodeFile._writeQrCode(
        data: data, fileName: 'user_qrcode.png');
  }

  static Future<File> getQrCode() async {
    final path = await QrCodeFile.localPath;
    return QrCodeFile._readContent('$path/user_qrcode.png');
  }
}
