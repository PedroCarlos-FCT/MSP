import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final String className;
  final String time;
  final String instructor;
  final String description;
  final String room;

  const EventCard({
    required this.className,
    required this.time,
    required this.instructor,
    required this.description,
    required this.room,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: SizedBox(
        height: _isExpanded ? 180.0 : 100.0,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.className,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16.0),
                    SizedBox(width: 4.0),
                    Text(
                      widget.time,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.room, size: 16.0),
                    SizedBox(width: 4.0),
                    Text(
                      '${widget.room}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (_isExpanded) ...[
                  Divider(),
                  SizedBox(height: 8.0),
                  Text(
                    'Instructor: ${widget.instructor}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Description: ${widget.description}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
