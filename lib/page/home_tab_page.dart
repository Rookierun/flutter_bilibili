import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';

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
      child: ListView(
        children: [if (widget.bannerList != null) _banner()],
      ),
    );
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(
        bannerList: widget.bannerList,
      ),
    );
  }
}
