import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  var tabs = ['推荐', '热门', '追播', '影视', '搞笑', '日常', '综合', '手机游戏', '短片·手书·配音'];
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    HiNavigator().addListener(listener = (current, pre) {
      if (widget == current.page || current.page is HomePage) {
      } else if (widget == pre?.page || pre?.page is HomePage) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    HiNavigator().removeListener((current, pre) => listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: _tabBar(),
            padding: const EdgeInsets.only(top: 30),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((tab) {
                return HomeTabPage(tab);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
      controller: _controller,
      isScrollable: true,
      indicator: const UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: primary, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15)),
      tabs: tabs.map<Tab>((tab) {
        return Tab(
            child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  tab,
                  style: const TextStyle(fontSize: 16),
                )));
      }).toList(),
    );
  }
}
