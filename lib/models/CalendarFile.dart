import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:worktracker/models/RoutineFile.dart';

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
    if(await _getFile())
      return json.decode(_jsonFile.readAsStringSync());
    else
      return createFile(_jsonFile);
  }

  Future<bool> _getFile() async {
    String path = await _getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    return _fileExists;
  }

  Future<Map<String, dynamic>> saveTodayInFile(String dateToday) async {
    if(await _getFile())
      _fileContent = await readFile();
    _fileContent[dateToday] = [];
    final routineContent = await RoutineFile().readFile();
    final keys = routineContent['routines'].keys;
    for (var key in keys) {
      key = int.parse(key);
      _fileContent[dateToday].add({
        'routine_id': key,
        'status': 1
      });
    }
    _saveContent();
    return _fileContent;
  }

  void _saveContent() {
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
  }

  Future<Map<String, dynamic>> addRoutineCalendar(
    int id
  ) async {
    if(await _getFile())
      _fileContent = await readFile();
    final Map newRoutine = {
      'routine_id': id,
      'status': 1
    };
    _fileContent.forEach((key, value) => value.insert(0, newRoutine));
    _saveContent();
    return _fileContent;
  }

  Map<String, dynamic> createFile(File _jsonFile) {
    _jsonFile.createSync();
    _fileExists = true;
    _saveContent();
    return json.decode(_jsonFile.readAsStringSync());
  }

  void updateDayRoutines(String date, List<dynamic> newDayRoutines) async {
    if(await _getFile())
      _fileContent = await readFile();
    _fileContent[date] = newDayRoutines;
    _saveContent();
  }

  Future<String> _getLocalPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
