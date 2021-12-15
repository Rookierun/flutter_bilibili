import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  String name;

  HomeTabPage(this.name, {Key? key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name),
    );
  }
}
