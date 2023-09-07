import 'dart:collection';
import 'dart:convert';
import 'dart:io';

class TranlationStringExtractor {
  static final RegExp _re1 = RegExp("'([^']+)'[ \t\r\n]*.tr");
  static final RegExp _re2 = RegExp('"([^"]+)"[ \t\r\n]*.tr');

  static final RegExp _re3 = RegExp("'''((.|\r|\n)*?)'''[ \t\r\n]*\.tr");
  static final RegExp _re4 = RegExp('"""((.|\r|\n)*?)"""[ \t\r\n]*\.tr');
  static final List<RegExp> regexes = [_re1, _re2, _re3, _re4];

  static void extractStrings(String directory, String outputFile,
      {bool isVerbose = false}) {
    write(read(directory, isVerbose: isVerbose), outputFile);
  }

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
            }
          }
        }
        if (isVerbose) {
          print(entity.path + '\t' + fileMatchCount.toString() + ' matches');
        }
      }
    }
    return map;
  }

  static void write(Map<String, String> map, String outputFile) {
    File(outputFile).writeAsStringSync(jsonEncode(map));
  }
}
