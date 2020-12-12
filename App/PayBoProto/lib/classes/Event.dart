import 'Contact.dart';

class Event {
  int categoryID = 0;
  int subCategoryID = 0;
  String eventHeading;
  String eventDescription;
  Contact contact;

  Event(
      {this.categoryID=0,
      this.subCategoryID=0,
      this.eventHeading,
      this.eventDescription,
      this.contact});

  factory Event.fromJSON(Map<String, dynamic> json) {
    return Event(
        categoryID: 0,
        subCategoryID: 0,
        eventHeading: json['eventHeading'],
        eventDescription: json['eventDescription'],
        contact: Contact.fromJSON(json['contact']));
  }
}
