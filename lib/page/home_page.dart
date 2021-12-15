import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/dao/home_dao.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  late TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator().addListener(listener = (current, pre) {
      if (widget == current.page || current.page is HomePage) {
      } else if (widget == pre?.page || pre?.page is HomePage) {}
    });
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    HiNavigator().removeListener((current, pre) => listener);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              children: categoryList.map((tab) {
                return HomeTabPage(
                  name: tab.name,
                  bannerList: tab.name == '推荐' ? bannerList : null,
                );
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
      tabs: categoryList.map<Tab>((tab) {
        return Tab(
            child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  tab.name ?? "空的",
                  style: const TextStyle(fontSize: 16),
                )));
      }).toList(),
    );
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get("推荐");
      print("home-page:result:$result");
      if (result.categoryList != null) {
        _controller =
            TabController(length: result.categoryList!.length, vsync: this);
      }
      setState(() {
        if (result.categoryList != null) {
          categoryList = result.categoryList!;
        }
        if (result.bannerList != null) {
          bannerList = result.bannerList!;
        }
      });
    } on NeedAuth catch (e) {
      print("loadData exception:$e");
      showWarnToast(e.toString());
    } on HiNetError catch (e) {
      print("loadData hiNetError exception:$e");
    }
  }
}
