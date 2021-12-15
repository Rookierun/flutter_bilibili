import 'package:flutter/material.dart';
import 'package:flutter_bilibili/dao/login_dao.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/toast.dart';

import 'navigator/bottom_navigator.dart';
import 'navigator/hi_navigator.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _delegate = BiliRouteDelegate();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      ///预初始化
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(
                routerDelegate: _delegate,
              )
            : const Scaffold(body: Center(child: CircularProgressIndicator()));
        return MaterialApp(
            home: widget, theme: ThemeData(primarySwatch: white));
      },
    );
  }
}

///路由代理类
class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  var videoModel;
  List<MaterialPage> pages = [];
  RouteStatus _routeStatus = RouteStatus.home;

  bool hasLogin = LoginDao.getBoardingPass() != null;
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转
    HiNavigator().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        videoModel = args?['videoMo'];
      }
      notifyListeners();
    }));
  }

  RouteStatus get routeStatus {
    hasLogin = LoginDao.getBoardingPass() != null;
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    //管理路由堆栈
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //当前页面在堆栈中已经存在
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }
    tempPages = [...tempPages, page];
    HiNavigator().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            if (!hasLogin) {
              showWarnToast("请先登录");
              return false;
            }
          }
          bool didPop = (route.didPop(result));
          if (!didPop) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          HiNavigator().notify(pages, tempPages);
          return true;
        },
      ),
      onWillPop: () async => !await navigatorKey.currentState!.maybePop(),
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}

///定义路由数据
class BiliRoutePath {
  final String location;
  BiliRoutePath.home() : location = "/";
  BiliRoutePath.detail() : location = "/detail";
}
