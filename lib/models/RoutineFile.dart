import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:worktracker/models/CalendarFile.dart';
import 'package:worktracker/models/Routine.dart';

class RoutineFile {
  String _fileName;
  bool _fileExists;
  File _jsonFile;
  Map<String, dynamic> _fileContent;

  RoutineFile() {
    _fileName = 'routine.json';
    _fileExists = false;
    _fileContent = {'routines': {}};
  }

  Future readFile() async {
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

  Future<Map<String, dynamic>> writeFile(
    Map<String, dynamic> routine
  ) async {
    String path = await _getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    _fileContent = await _saveRoutine(routine);
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
    final Map<String, dynamic> calendar =
      await CalendarFile().addRoutineCalendar(_fileContent['routines'].keys.length);
    return calendar;
  }

  Future _saveRoutine(
    Map<String, dynamic> routine
  ) async {
    if(_fileExists)
      _fileContent = await readFile();
    final int length = _fileContent['routines'].length;
    routine['days'] = [];
    _fileContent['routines']['${length + 1}'] = routine;
    return _fileContent;
  }

  Future saveRoutineDay(Routine routine, int day) async {
    _fileContent = await readFile();
    int index = _fileContent['routines']
        .indexWhere((element) => identical(element, routine));
    _fileContent['routines'][index]['days'].append(day);
    return _fileContent;
  }

  Future<String> _getLocalPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
