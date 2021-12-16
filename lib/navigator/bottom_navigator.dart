import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/favorite_page.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/page/ranking_page.dart';
import 'package:flutter_bilibili/util/color.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);
  late List<Widget> _pages;
  bool _hasBuild = false;
  static int inititalPage = 0;
  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(
        onJumpTo: (index) => _onItemTapped(index, pageChange: false),
      ),
      RankingPage(),
      FavoritePage(),
      ProfilePage()
    ];
    if (!_hasBuild) {
      HiNavigator().onBottomTabChange(inititalPage, _pages[inititalPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        onPageChanged: (index) => _onItemTapped(index, pageChange: true),
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _bottomItem('首页', Icons.home, 0),
          _bottomItem("排行", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 3),
          _bottomItem("我的", Icons.live_tv, 3),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: _activeColor,
        onTap: (index) => _onItemTapped(index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  BottomNavigationBarItem _bottomItem(
      String title, IconData iconData, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: _defaultColor,
      ),
      activeIcon: Icon(
        iconData,
        color: _activeColor,
      ),
      label: title,
    );
  }

  void _onItemTapped(int index, {pageChange = false}) {
    if (!pageChange) {
      _controller.jumpToPage(index);
    } else {
      HiNavigator().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      _currentIndex = index;
    });
  }
}
