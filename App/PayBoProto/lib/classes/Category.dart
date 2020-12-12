import 'package:PayBoProto/classes/SubCategory.dart';

class Category {
  int categoryID;
  String categoryName;
  List<SubCategory> subCategoryList;

  Category({this.categoryID, this.categoryName, this.subCategoryList});
}
