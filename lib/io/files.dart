import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Files {

  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getLocalFile(filename) async {
    final path = await getLocalPath();
    return new File('$path/$filename');
  }

  Future<File> createIfNot(filename) async {
    File file = await getLocalFile(filename);
    return file.exists().then((exists) {
      if (!exists) {
        return file.create();
      }
    });
  }

  Future<File> overwrite(filename, text) async {
    File file = await getLocalFile(filename);
    return file.writeAsString(text);
  }

  Future<String> read(filename) async {
    try {
      File file = await getLocalFile(filename);
      var contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<File> write(filename, content) async {
    File file = await getLocalFile(filename);
    return file.writeAsString(content, mode: FileMode.write);
  }
}
