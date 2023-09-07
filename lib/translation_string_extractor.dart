import 'dart:collection';
import 'dart:convert';
import 'dart:io';

/// Class extracts Strings from Dart files in a directory.
class TranlationStringExtractor {
  static final RegExp _re1 = RegExp(r"'([^']+)'\s*\.tr");
  static final RegExp _re2 = RegExp(r'"([^"]+)"\s*\.tr');

  static final RegExp _re3 = RegExp(r"'''([^']+?)'''\s*\.tr");
  static final RegExp _re4 = RegExp(r'"""([^"]+?)"""\s*\.tr');
  static final List<RegExp> regexes = [_re1, _re2, _re3, _re4];

  /// Extracts Strings in a directory and writes the resulting JSON
  /// in a File.
  static void extractStrings(String directory, String outputFile,
      {bool isVerbose = false}) {
    write(read(directory, isVerbose: isVerbose), outputFile);
  }

  /// Scans a directory for Strings and returns a Map onject with these Strings.
  static Map<String, String> read(String directory, {isVerbose = false}) {
    SplayTreeMap<String, String> map = SplayTreeMap<String, String>();

    for (final FileSystemEntity entity in Directory(directory)
        .listSync(recursive: true)
        .where((element) => element.path.endsWith('.dart'))
        .where((element) => element.path.endsWith('.g.dart') == false)) {
      if (entity is File) {
        int fileMatchCount = 0;
        final content = File(entity.path).readAsStringSync();
        for (final RegExp regex in regexes) {
          final matches = regex.allMatches(content);

          for (final RegExpMatch match in matches) {
            final extract = match.group(1);

            if (extract != null) {
              map.putIfAbsent(extract, () => extract);
              fileMatchCount++;
            }
          }
        }
        if (isVerbose && fileMatchCount > 0) {
          print(fileMatchCount.toString() + ' strings' + '\t' + entity.path);
        }
      }
    }

    if (isVerbose) {
      print(map.keys.length.toString() + ' unique strings');
    }

    return map;
  }

  /// Serializes a Map object into JSON and writes that in a File.
  static void write(Map<String, String> map, String outputFile) {
    File(outputFile).writeAsStringSync(jsonEncode(map));
  }
}
