import 'package:args/args.dart';
import 'package:translation_string_extractor/translation_string_extractor.dart';

void main(List<String> arguments) {
  final argParser = ArgParser()
    ..addOption('dir', abbr: 'd', defaultsTo: './lib')
    ..addOption('output', abbr: 'o', defaultsTo: 'strings.json')
    ..addOption('verbose', abbr: 'v', hide: true);

  final argResults = argParser.parse(arguments);

  final directory = argResults['dir'];
  final outputFile = argResults['output'];
  final isVerbose = argResults['verbose'] != null;

  TranlationStringExtractor.extractStrings(directory, outputFile,
      isVerbose: isVerbose);
}
