import 'package:PayBoProto/classes/Category.dart';
import 'package:PayBoProto/widgets/TileEntry.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final List<Category> categories;
  CategoryScreen(this.categories);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
<<<<<<< HEAD
      itemCount: widget.categories.length,
      itemBuilder: (BuildContext context, int index) =>
          TileEntry(widget.categories[index]),
=======
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) =>
          TileEntry(categories[index]),
>>>>>>> 427dd2a173c27f9a2212bf9526f842c94835e028
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    );
  }
}
