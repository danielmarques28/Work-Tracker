import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class CalendarFile {
  String _fileName;
  bool _fileExists;
  File _jsonFile;
  Map<String, dynamic> _fileContent;

  CalendarFile() {
    _fileName = 'calendar.json';
    _fileExists = false;
    _fileContent = _generateDaysWithRoutines();
  }

  Object _generateDaysWithRoutines() {
    Map<String, dynamic> calendar = {};
    for(int i = 364; i >= 0; i--) {
      DateTime day = DateTime.now().add(Duration(days: -i));
      calendar[day.toString().substring(0, 10)] = [];
    }
    return calendar;
  }

  Future<Map<String, dynamic>> readFile() async {
    String path = await _getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    if(_fileExists) {
      return json.decode(_jsonFile.readAsStringSync());
    }
    else
      return createFile(_jsonFile);
  }

  Map<String, dynamic> createFile(File _jsonFile) {
    _jsonFile.createSync();
    _fileExists = true;
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
    return json.decode(_jsonFile.readAsStringSync());
  }

  void writeFile(String date, int value) async {
    String path = await _getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    if(_fileExists)
      _fileContent = await readFile();
    _fileContent[date].append(value);
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
  }

  Future<String> _getLocalPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
