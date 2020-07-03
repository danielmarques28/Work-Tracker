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
    _fileContent = {'calendar': _generateDaysWithRoutines()};
  }

  List<Object> _generateDaysWithRoutines() {
    final items = List.generate(365, (i) {
      final day = DateTime.now().add(Duration(days: -i));
      return {
        'day': day.toString().substring(0, 10),
        'routines': []
      };
    });
    return items;
  }

  Future<Map<String, dynamic>> readFile() async {
    String path = await getLocalPath();
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

  void writeFile(String key, int value) async {
    String path = await getLocalPath();
    _jsonFile = File('$path/$_fileName');
    _fileExists = _jsonFile.existsSync();
    if(_fileExists)
      _fileContent = await readFile();
    _fileContent[key].append(value);
    _jsonFile.writeAsStringSync(json.encode(_fileContent));
  }

  Future<String> getLocalPath() async {
    Directory directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
