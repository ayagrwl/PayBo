import 'package:PayBoProto/classes/Category.dart';
import 'package:PayBoProto/screens/donation.dart';
import 'package:flutter/material.dart';

class TileEntry extends StatefulWidget {
  final Category category;
  TileEntry(this.category);
  @override
  _TileEntryState createState() => _TileEntryState(category);
}

class _TileEntryState extends State<TileEntry> {
  Category category;
  _TileEntryState(this.category);
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      childrenPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      title: Text(
        category.categoryName,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      children: [_createChildrenTiles(category)],
    );
  }

  _createChildrenTiles(Category category) {
    return Column(
      children: [
        for (var subcategory in category.subCategoryList)
          ListTile(
            title: Text(subcategory.subCategoryName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Donation(subcategory.subCategoryName),
                ),
              );
            },
          ),
      ],
    );
  }
}
