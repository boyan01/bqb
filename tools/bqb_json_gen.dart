import 'dart:convert';
import 'dart:io';

import 'package:bqb/repository/model.dart';
import 'package:path/path.dart';

const _imageUriPrefix = 'https://raw.githubusercontent.com/zhaoolee/ChineseBQB/master/';

final assetsPath = Directory(Directory.current.path + "/web/assets").path;

final bqbDir = Directory(Directory.current.path + "/ChineseBQB");

main() async {
  assert(await bqbDir.exists(), "can not find ChineseBQB directory");
  final categories = bqbDir.listSync()
    ..removeWhere((element) => element is File) //skip file
    ..removeWhere((element) => basename(element.path).startsWith('000')) //skip contribution
    ..removeWhere((element) => basename(element.path).startsWith('.')) //skip hidden file
    ..sort((a, b) => a.path.compareTo(b.path));

  final categoryMap = categories.map((category) => _buildCategory(category)).toList();
  final json = jsonEncode(categoryMap);

//  final compressed = GZipCodec().encode(utf8.encode(result));
  _flushToFile(utf8.encode(json), filename: bqbManifestName);
}

Map _buildCategory(Directory category) {
  final bqbs = category.listSync()
    ..removeWhere((element) => element.path.endsWith('.md'))
    ..sort((a, b) => a.path.compareTo(b.path));
  return Category(
    name: basename(category.path),
    data: bqbs.whereType<File>().map(_buildBqbItem).toList(),
  ).toJson();
}

BqbItem _buildBqbItem(File bqb) {
  return BqbItem(
    assetName: _imageUriPrefix + bqb.path.replaceAll(bqbDir.path, ''),
    name: basename(bqb.path),
    size: bqb.statSync().size,
  );
}

///write data to file
void _flushToFile(List<int> data, {String filename = 'manifest.json'}) {
  assert(filename != null);

  final outputFile = File('$assetsPath/$filename');
  if (outputFile.existsSync()) {
    outputFile.deleteSync();
  }
  outputFile.createSync();
  outputFile.openSync(mode: FileMode.write)
    ..writeFromSync(data)
    ..closeSync();
}
