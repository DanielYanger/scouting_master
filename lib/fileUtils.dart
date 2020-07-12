import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  static Future<File> get pickFile async {
    Future<File> file = FilePicker.getFile(type: FileType.any);
    return file;
  }

  static Future<String> readFile(Future<File> file) async {
    final schedule = await file;
    return schedule.readAsString();
  }

  static Future<bool> saveToFile(String data, String title) async {
    final path = getFilePath;
    var directory = new Directory('$path/forms');
    directory.create();
    var file = new File('$path/forms/$title.txt');
    print(file.path);
    print(data);
    file.create();
    //return file.writeAsString(data);
    await FlutterShare.shareFile(
      title: 'Saving Form',
      text: 'Save form',
      filePath: file.path,
    ).then((value) => print(value));
    print("Hello");
    return true;
  }

  static Future<String> createFile(String fileName) async {
    final path = await getFilePath;
    var file = new File('$path/$fileName.txt');
    print(file.path);
    file.create();
    return "Success";
  }
}
