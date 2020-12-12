import 'package:PayBoProto/classes/Category.dart';
import 'package:PayBoProto/widgets/TileEntry.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final List<Category> categories;
  CategoryScreen(this.categories);
  @override
  _CategoryScreenState createState() => _CategoryScreenState(categories);
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> categories;
  _CategoryScreenState(this.categories);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) =>
          TileEntry(categories[index]),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    );
  }
}
