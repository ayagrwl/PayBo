class Contact {
  String contactName;
  String contactEmail;
  String contactNumber;

  Contact({this.contactName, this.contactEmail, this.contactNumber});

  factory Contact.fromJSON(Map<String, dynamic> json) {
    return Contact(
      contactName: json['name'],
      contactEmail: json['email'],
      contactNumber: json['phone'],
    );
  }
}
