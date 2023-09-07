import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:translation_string_extractor/translation_string_extractor.dart';

void main() {
  test('map', () {
    var expected =
        r'{"A":"A","A 2":"A 2","Appbar Title":"Appbar Title","Appbar Title 2":"Appbar Title 2","B C D":"B C D","B C D 2":"B C D 2","E \r\n            C D 2":"E \r\n            C D 2","E \r\n            C D broken 1":"E \r\n            C D broken 1","E \r\n            C D broken 2":"E \r\n            C D broken 2","E C D on line":"E C D on line"}';
    final map = TranlationStringExtractor.read('test/source');
    expect(jsonEncode(map), expected);
  });

  test('file', () {
    final jsonFile = 'test/source/source.json';

    var expected =
        r'{"A":"A","A 2":"A 2","Appbar Title":"Appbar Title","Appbar Title 2":"Appbar Title 2","B C D":"B C D","B C D 2":"B C D 2","E \r\n            C D 2":"E \r\n            C D 2","E \r\n            C D broken 1":"E \r\n            C D broken 1","E \r\n            C D broken 2":"E \r\n            C D broken 2","E C D on line":"E C D on line"}';

    TranlationStringExtractor.extractStrings('test/source', jsonFile);
    expect(File(jsonFile).readAsStringSync(), expected);
  });
}
