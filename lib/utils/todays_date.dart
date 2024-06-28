import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('MMMM, d EEEE').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("Date Display"),
      ),
      body: Center(
        child: Text(
          formattedDate,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
