import 'package:bqb/repository/bqb_source.dart';
import 'package:bqb/repository/model.dart';
import 'package:flutter_web/material.dart';

import 'category_detail.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        childAspectRatio: 16 / 10,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
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
    return InkWell(
      onHover: (hover) {
        debugPrint("on hover : ${category.name}");
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailPage(category: category)));
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(child: Image.network(category.data.first.imageUrl, fit: BoxFit.cover)),
          _Title(title: category.name),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        constraints: BoxConstraints.tightFor(width: double.infinity),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black26, Colors.black45],
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).primaryTextTheme.title,
          maxLines: 2,
        ),
      ),
    );
  }
}
