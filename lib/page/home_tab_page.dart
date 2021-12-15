import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_mo.dart';

class HomeTabPage extends StatefulWidget {
  String? name;
  List<BannerMo>? bannerList;

  HomeTabPage({Key? key, this.name, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name ?? "空的"),
    );
  }
}
