import 'package:flutter/material.dart';

class AssignmentListTile extends StatelessWidget {
  AssignmentListTile({
    this.name,
    this.uid,
    this.type,
    this.description,
    this.categories,
    this.dtstamp,
    this.dtend,
    this.dtstart,
  });

  final List<String> categories;
  final String description;
  final DateTime dtend;
  final DateTime dtstamp;
  final DateTime dtstart;
  final String name;
  final String type;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(name),
          Text(description),
          Text(categories.first ?? ''),
        ],
      ),
    );
  }
}
