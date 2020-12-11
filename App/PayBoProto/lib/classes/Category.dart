import 'package:PayBoProto/classes/SubCategory.dart';

class Category {
  int categoryID;
  String categoryName;
  List<SubCategory> subCategoryList;

  Category({this.categoryID, this.categoryName, this.subCategoryList});
}

/*
Category technicals = new Category(
    categoryID: 1,
    categoryName: "Technicals",
    subCategoryList: technicalSubCategoryList);
Category culturals = new Category(
    categoryID: 2,
    categoryName: "Culturals",
    subCategoryList: culturalSubCategoryList);
Category avana = new Category(
    categoryID: 3,
    categoryName: "Avana",
    subCategoryList: avanaSubCategoryList);
Category donation = new Category(
    categoryID: 4,
    categoryName: "Donation",
    subCategoryList: donationSubCategoryList);
*/

