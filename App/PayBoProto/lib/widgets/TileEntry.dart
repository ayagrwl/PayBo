import 'package:PayBoProto/classes/Category.dart';
import 'package:PayBoProto/screens/FormScreen.dart';
import 'package:flutter/material.dart';


class TileEntry extends StatefulWidget {
  final Category category;
  TileEntry(this.category);
  @override
  _TileEntryState createState() => _TileEntryState();
}

class _TileEntryState extends State<TileEntry> {

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      childrenPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      title: Text(
        widget.category.categoryName,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      children: [_createChildrenTiles(widget.category)],
    );
  }

  _createChildrenTiles(Category category) {
    return Column(
      children: [
        for (var subcategory in category.subCategoryList)
          ListTile(
            title: Text(subcategory.subCategoryName),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormScreen(subcategory.subCategoryName, category.categoryID, subcategory.subCategoryID)));
            },
          ),
      ],
    );
  }
}
