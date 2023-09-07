import 'dart:collection';
import 'dart:convert';
import 'dart:io';

class TranlationStringExtractor {
  static final RegExp _re1 = RegExp("'([^']+)'[ \t\r\n]*.tr");
  static final RegExp _re2 = RegExp('"([^"]+)"[ \t\r\n]*.tr');

  static final RegExp _re3 = RegExp("'''((.|\r|\n)*?)'''[ \t\r\n]*\.tr");
  static final RegExp _re4 = RegExp('"""((.|\r|\n)*?)"""[ \t\r\n]*\.tr');
  static final List<RegExp> regexes = [_re1, _re2, _re3, _re4];

  static void extractStrings(String directory, String outputFile) {
    write(read(directory), outputFile);
  }

  static Map<String, String> read(String directory) {
    SplayTreeMap<String, String> map = SplayTreeMap<String, String>();

    for (final FileSystemEntity entity in Directory(directory)
        .listSync(recursive: true)
        .where((element) => element.path.endsWith('.dart'))) {
      if (entity is File) {
        final content = File(entity.path).readAsStringSync();
        for (final RegExp regex in regexes) {
          final matches = regex.allMatches(content);

          for (final RegExpMatch match in matches) {
            final extract = match.group(1);

            if (extract != null) {
              map.putIfAbsent(extract, () => extract);
            }
          }
        }
      }
    }
    return map;
  }

  static void write(Map<String, String> map, String outputFile) {
    File(outputFile).writeAsStringSync(jsonEncode(map));
  }
}
