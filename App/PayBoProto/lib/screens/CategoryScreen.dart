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
  /*Category technicals, culturals, avana, donation;
  SubCategory robotics,
      programming,
      aeromodelling,
      dsc,
      cynaptics,
      electronics,
      tea,
      cae,
      concreate,
      metacryst,
      cfa,
      astronomy,
      techfest;
  SubCategory dance, music, drama, kalakriti, docm, debsoc, literary, quiz, mun, cultFest;
  SubCategory orm, donationDrive;
  SubCategory kerelaRF, biharRF;
  List<SubCategory> technicalSubCategoryList,
      culturalSubCategoryList,
      avanaSubCategoryList,
      donationSubCategoryList;
  List<Category> categories;
  @override
  void initState() {
    super.initState();
    robotics =
        new SubCategory(subCategoryID: 11, subCategoryName: "Robtics Club");
    programming =
        new SubCategory(subCategoryID: 12, subCategoryName: "Programming Club");
    aeromodelling =
        new SubCategory(subCategoryID: 13, subCategoryName: "Aeromodelling Club");
    dsc =
        new SubCategory(subCategoryID: 14, subCategoryName: "Developer Students Club");
    cynaptics =
        new SubCategory(subCategoryID: 15, subCategoryName: "Cynaptics Club");
    electronics =
        new SubCategory(subCategoryID: 16, subCategoryName: "Electronics Club");
    tea =
        new SubCategory(subCategoryID: 17, subCategoryName: "Team Engines and Daemons Club");
    cae =
        new SubCategory(subCategoryID: 18, subCategoryName: "CAE Club");
    concreate =
        new SubCategory(subCategoryID: 19, subCategoryName: "Concreate Club");
    metacryst =
        new SubCategory(subCategoryID: 20, subCategoryName: "Metacryst Club");
    cfa =
        new SubCategory(subCategoryID: 21, subCategoryName: "CFA Club");
    astronomy =
        new SubCategory(subCategoryID: 22, subCategoryName: "Astronomy Club");
    techfest =
        new SubCategory(subCategoryID: 23, subCategoryName: "Technical Fest");

    dance = new SubCategory(subCategoryID: 51, subCategoryName: "Dance Club");
    music = new SubCategory(subCategoryID: 52, subCategoryName: "Music Club");
    drama = new SubCategory(subCategoryID: 53, subCategoryName: "Drama Club");
    kalakriti = new SubCategory(subCategoryID: 54, subCategoryName: "Kalakriti Club");
    docm = new SubCategory(subCategoryID: 55, subCategoryName: "DOCM Club");
    debsoc = new SubCategory(subCategoryID: 56, subCategoryName: "Debating Society");
    literary = new SubCategory(subCategoryID: 57, subCategoryName: "Literary Club");
    quiz = new SubCategory(subCategoryID: 58, subCategoryName: "Quiz Club");
    mun = new SubCategory(subCategoryID: 59, subCategoryName: "MUN");
    cultFest = new SubCategory(subCategoryID: 60, subCategoryName: "FLUXUS");

    orm = new SubCategory(subCategoryID: 101, subCategoryName: "ORM");
    donationDrive = new SubCategory(subCategoryID: 102, subCategoryName: "Donation Drive");

    kerelaRF = new SubCategory(
        subCategoryID: 151, subCategoryName: "Kerela Relief Fund");
    biharRF = new SubCategory(
        subCategoryID: 152, subCategoryName: "Bihar Relief Fund");

    technicalSubCategoryList = [
      robotics,
      programming,
      aeromodelling,
      dsc,
      cynaptics,
      electronics,
      tea,
      cae,
      concreate,
      metacryst,
      cfa,
      astronomy
    ];
    culturalSubCategoryList = [
      dance,
      music,
      drama,
      kalakriti,
      docm,
      debsoc,
      literary,
      quiz,
      mun,
      cultFest
    ];
    avanaSubCategoryList = [orm, donationDrive];
    donationSubCategoryList = [kerelaRF, biharRF];

    technicals = new Category(
        categoryID: 1,
        categoryName: "Technicals",
        subCategoryList: technicalSubCategoryList);
    culturals = new Category(
        categoryID: 2,
        categoryName: "Culturals",
        subCategoryList: culturalSubCategoryList);
    avana = new Category(
        categoryID: 3,
        categoryName: "Avana",
        subCategoryList: avanaSubCategoryList);
    donation = new Category(
        categoryID: 4,
        categoryName: "Donation",
        subCategoryList: donationSubCategoryList);
    categories = [technicals, culturals, avana, donation];
  }*/

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
