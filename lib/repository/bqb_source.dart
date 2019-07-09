import 'dart:convert';

import 'package:flutter_web/widgets.dart';

import 'model.dart';

/// 加载表情包数据
Future<List<Category>> loadBqbData() async {
  final bytes = await rootBundle.load(bqbManifestName);
  List categories = jsonDecode(utf8.decode(bytes.buffer.asUint8List()));
  return categories.map((e) => Category.formJson(e)).toList();
}
