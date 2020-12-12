import 'package:PayBoProto/classes/Category.dart';
import 'package:PayBoProto/classes/SubCategory.dart';

import 'Contact.dart';

class Event {
  Category category;
  SubCategory subCategory;
  int eventID;
  String eventHeading;
  String eventDescription;
  Contact contact;

  Event(
      {this.category,
      this.subCategory,
      this.eventID,
      this.eventHeading,
      this.eventDescription,
      this.contact});
}
