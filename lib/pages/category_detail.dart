import 'package:bqb/repository/model.dart';
import 'package:flutter_web/material.dart';

class CategoryDetailPage extends StatelessWidget {
  final Category category;

  const CategoryDetailPage({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: category.data.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 16 / 10,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return Image.network(category.data[index].imageUrl);
        },
      ),
    );
  }
}
