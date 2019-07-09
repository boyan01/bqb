const bqbManifestName = 'BqbManifest.json';

class Category {
  final String name;

  final List<BqbItem> data;

  Category({this.name, this.data});

  Map toJson() {
    return {
      'name': name,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  factory Category.formJson(Map map) {
    return Category(
      name: map['name'],
      data: (map['data'] as List).map((e) => BqbItem.fromJson(e)).toList(),
    );
  }
}

class BqbItem {
  final String name;
  final String assetName;
  final int size;

  BqbItem({this.name, this.assetName, this.size});

  Map toJson() {
    return {
      'name': name,
      'assetName': assetName,
      'size': size,
    };
  }

  factory BqbItem.fromJson(Map map) {
    return BqbItem(
      name: map['name'],
      assetName: map['assetName'],
      size: map['size'],
    );
  }
}
