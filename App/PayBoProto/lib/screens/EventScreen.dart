import 'package:PayBoProto/classes/Event.dart';
import 'package:PayBoProto/widgets/EventEntry.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  final List<Event> events;
  EventScreen(this.events);
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          EventEntry(widget.events[index]),
      itemCount: widget.events.length,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    );
  }
}
