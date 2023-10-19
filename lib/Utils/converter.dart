import 'dart:io';
import 'dart:typed_data';

Future<Uint8List> fileToBlob(File file) async {
  Uint8List uint8list = await file.readAsBytes();
  return uint8list;
}