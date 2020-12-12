import 'Contact.dart';

class Event {
  int categoryID;
  int subCategoryID;
  int eventID;
  String eventHeading;
  String eventDescription;
  Contact contact;

  Event(
      {this.categoryID,
      this.subCategoryID,
      this.eventID,
      this.eventHeading,
      this.eventDescription,
      this.contact});

  factory Event.fromJSON(Map<String, dynamic> json) {
    return Event(
      categoryID: json['category'],
      subCategoryID: json['subCategory'],
      eventID: json['eventID'],
      eventHeading: json['eventHeading'],
      eventDescription: json['eventDescription'],
      contact: Contact.fromJSON(json['contact'])
    );
  }
}
