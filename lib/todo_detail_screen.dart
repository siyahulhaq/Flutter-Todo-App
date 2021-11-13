import 'package:flutter/material.dart';

class TodoDetailsScreen extends StatefulWidget {
  String title;
  String description;
  int position;

  TodoDetailsScreen(
      {Key? key, this.title = '', this.description = '', this.position = 0})
      : super(key: key);

  @override
  _TodoDetailsScreenState createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  final primaryColor = const Color(0xFF151026);
  final inPrimaryColor = const Color(0xFF151030);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
