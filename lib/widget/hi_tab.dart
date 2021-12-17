import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unSelectedLabelColor;

  const HiTab(this.tabs,
      {this.controller,
      this.fontSize = 13,
      this.borderWidth = 3,
      this.insets = 15,
      this.unSelectedLabelColor = Colors.grey,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      labelColor: primary,
      labelStyle: TextStyle(fontSize: fontSize),
      unselectedLabelColor: unSelectedLabelColor,
      indicator: const UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: primary, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15)),
      tabs: tabs,
    );
  }
}
