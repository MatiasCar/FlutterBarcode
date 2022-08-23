import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<File> save(String content) async {
  final directory = (await getExternalStorageDirectory())?.path;
  final file = File('$directory/Log.txt');
  String texto = '';
  if (file.existsSync()) {
    texto = await file.readAsString();
  }
  return file
      .writeAsString('$texto \nCodigo de barra: $content - ${DateTime.now()}');
}
