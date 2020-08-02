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
    for(int i = 90; i >= 0; i--) {
      DateTime day = DateTime.now().add(Duration(days: -i));
      calendar[day.toString().substring(0, 10)] = [];
    }

    return calendar;
  }

  Future<Map<String, dynamic>> readFile() async {
    String path = await _getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    if(_fileExists)
      return json.decode(_jsonFile.readAsStringSync());
    else
      return createFile(_jsonFile);
  }

  Future<Map<String, dynamic>> addRoutineCalendar(
    int id
  ) async {
    String path = await _getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    if(_fileExists)
      _fileContent = await readFile();
    final Map newRoutine = {
      'routine_id': id,
      'status': 1
    };
    _fileContent.forEach((key, value) => value.insert(0, newRoutine));
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
    return _fileContent;
  }

  Map<String, dynamic> createFile(File _jsonFile) {
    _jsonFile.createSync();
    _fileExists = true;
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
    return json.decode(_jsonFile.readAsStringSync());
  }

  void updateDayRoutines(String date, List<dynamic> newDayRoutines) async {
    String path = await _getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    if(_fileExists)
      _fileContent = await readFile();
    _fileContent[date] = newDayRoutines;
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
  }

  Future<String> _getLocalPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
