import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class NavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  late Widget? child;

  NavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      child: child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
    );
  }

  void _statusBarInit() {
    FlutterStatusbarManager.setColor(color, animated: false);
    FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.DARK_CONTENT
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }
}
