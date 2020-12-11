import 'package:PayBoProto/classes/Event.dart';
import 'package:flutter/material.dart';

class EventEntry extends StatefulWidget {
  final Event event;
  EventEntry(this.event);
  @override
  _EventEntryState createState() => _EventEntryState(event);
}

class _EventEntryState extends State<EventEntry> {
  Event event;
  _EventEntryState(this.event);

  @override
  Widget build(BuildContext context) {
    return Card(
      
    );
  }
}
