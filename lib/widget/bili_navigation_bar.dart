import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/view_util.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class BiLiNavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  late Widget? child;

  BiLiNavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      this.child})
      : super(key: key);

  @override
  _BiLiNavigationBarState createState() => _BiLiNavigationBarState();
}

class _BiLiNavigationBarState extends State<BiLiNavigationBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _statusBarInit();
  }

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
    );
  }

  void _statusBarInit() {
    changeStatusBar(color: widget.color, statusStyle: widget.statusStyle);
  }
}
