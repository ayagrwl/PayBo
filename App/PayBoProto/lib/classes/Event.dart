import 'package:PayBoProto/classes/Category.dart';
import 'package:PayBoProto/classes/SubCategory.dart';

class Event {
  Category category;
  SubCategory subCategory;
  int eventID;
  String eventHeading;
  String eventDescription;

  Event(
      {this.category,
      this.subCategory,
      this.eventID,
      this.eventHeading,
      this.eventDescription});
}
