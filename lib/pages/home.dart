import 'package:bqb/repository/bqb_source.dart';
import 'package:bqb/repository/model.dart';
import 'package:flutter_web/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: FutureBuilder<List<Category>>(
        future: loadBqbData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return BqbCategoryList(data: snapshot.data);
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class BqbCategoryList extends StatelessWidget {
  final List<Category> data;

  const BqbCategoryList({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return CategoryView(category: data[index]);
      },
    );
  }
}

class CategoryView extends StatelessWidget {
  final Category category;

  const CategoryView({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(category.data.first.imageUrl),
        Container(
          color: Colors.black26,
          child: Center(child: Text(category.name)),
        ),
      ],
    );
  }
}
