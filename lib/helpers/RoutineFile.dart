import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:worktracker/helpers/Routine.dart';

class RoutineFile {
  String _fileName;
  bool _fileExists;
  File _jsonFile;
  Map<String, dynamic> _fileContent;

  RoutineFile() {
    _fileName = 'routine.json';
    _fileExists = false;
    _fileContent = {'routines': []};
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

  void writeFile(Routine routine) async {
    String path = await _getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    _fileContent = await _saveRoutine(routine);
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
  }

  Future<Map<String, dynamic>> _saveRoutine(Routine routine) async {
    if(_fileExists)
      _fileContent = await readFile();
    _fileContent['routines'].append(routine);
    return _fileContent;
  }

  Future<Map<String, dynamic>> saveRoutineDay(Routine routine, int day) async {
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
