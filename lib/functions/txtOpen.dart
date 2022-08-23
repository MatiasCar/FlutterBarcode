import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<void> openTxt() async {
  final directory = (await getExternalStorageDirectory())?.path;
  final file = File('$directory/Log.txt');
  final fileConvert = file.path;
  OpenFile.open(fileConvert);
}
