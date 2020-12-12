import 'package:PayBoProto/classes/Event.dart';
import 'package:PayBoProto/widgets/EventEntry.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  final List<Event> events;
  EventScreen(this.events);
  @override
  _EventScreenState createState() => _EventScreenState(events);
}

class _EventScreenState extends State<EventScreen> {
  List<Event> events;
  _EventScreenState(this.events);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => EventEntry(events[index]),
      itemCount: events.length,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    );
  }
}
