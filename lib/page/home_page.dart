import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core//hi_state.dart';
import 'package:flutter_bilibili/dao/home_dao.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/bili_navigation_bar.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  var listener;
  late TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  Widget? _currentPage;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator().addListener(listener = (current, pre) {
      _currentPage = current.page;
      if (widget == current.page || current.page is HomePage) {
      } else if (widget == pre?.page || pre?.page is HomePage) {}
      if (pre?.page is VideoDetailPage && current.page is! ProfilePage) {
        var statusStyle = StatusStyle.DARK_CONTENT;
        changeStatusBar(color: Colors.white, statusStyle: statusStyle);
      }
    });
    loadData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        print("home_page :detached ");
        break;
      case AppLifecycleState.inactive:
        print("home_page :inactive ");
        break;
      case AppLifecycleState.resumed:
        if (_currentPage == null) {
          return;
        }
        if (_currentPage is! VideoDetailPage) {
          changeStatusBar(
              color: Colors.white, statusStyle: StatusStyle.DARK_CONTENT);
        }
        break;
      case AppLifecycleState.paused:
        print("home_page :paused ");
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    HiNavigator().removeListener((current, pre) => listener);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          BiLiNavigationBar(
            height: 50,
            child: _appBar(),
            color: Colors.white,
            statusStyle: StatusStyle.DARK_CONTENT,
          ),
          Container(
            color: Colors.white,
            child: _tabBar(),
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
    return HiTab(
      categoryList.map<Tab>((e) {
        return Tab(
          child: Text(e.name ?? ""),
        );
      }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unSelectedLabelColor: Colors.black54,
      insets: 13,
    );
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get("推荐");
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

  _appBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: const Image(
                  width: 46,
                  height: 46,
                  image: AssetImage('images/avatar.png')),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.search, color: Colors.grey),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          const Icon(Icons.explore_outlined, color: Colors.grey),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.mail_outline, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
