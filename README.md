# Translation String Extractor

Extracts strings marked for translation with `.tr` or `.tr()` and writes them into JSON file or returns a Map.

Input: 

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Hello'.tr),
      Text("""World""".tr),
    ]);
  }
}
```

Output:

```json
{
  "Hello": "Hello",
  "World": "World"
}
```


## Installation

```yaml
dev_dependencies:
  translation_string_extractor: <latest>
```

Or install the package globally:

```bash
dart pub global activate translation_string_extractor
```
## Usage

As a dev dependency:

```bash 
dart run translation_string_extractor:extract -d=lib -o=locale.json
```

Globally:

```bash
translation_string_extractor ./lib output.json
```

Public Signature:

```dart

TranlationStringExtractor ...

static void extractStrings(String directory, String outputFile);

static Map<String, String> read(String directory) {
  SplayTreeMap<String, String> map = SplayTreeMap<String, String>();

static void write(Map<String, String> map, String outputFile);
```

## Issues

https://github.com/xErik/translation_string_extractor/issues

## License

This package is licensed under the MIT license.
