import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/bottom_navigator.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? pre);
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

///获取routeStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  var length = pages.length;
  for (int i = 0; i < length; i++) {
    if (getStatus(pages[i]) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///自定义路由状态
enum RouteStatus { login, registration, home, detail, unknown }

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }
  return RouteStatus.unknown;
}

///路由信息
class RouteStatusInfo {
  final RouteStatus status;
  final Widget page;

  RouteStatusInfo(this.status, this.page);
}

///l路由统一管理
class HiNavigator extends _RouteJumpListener {
  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;
  static final HiNavigator _instance = HiNavigator._internal();
  RouteStatusInfo? _bottomTab;
  factory HiNavigator() {
    return _instance;
  }
  HiNavigator._internal();

  late RouteJumpListener? _routeJump;

  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  void notify(List<MaterialPage> currPages, List<MaterialPage> prePages) {
    if (currPages == prePages) {
      return;
    }
    var current =
        RouteStatusInfo(getStatus(currPages.last), currPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      //如果打开的是首页，则明确tab
      current = _bottomTab!;
    }
    for (var element in _listeners) {
      element(current, _current);
    }
    _current = current;
  }

  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJump = routeJumpListener;
  }

  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  @override
  void onJumpTo(RouteStatus status, {Map<dynamic, dynamic>? args}) {
    (_routeJump!.onJumpTo)!(status, args: args);
  }

  Future<bool> openH5(String url) async {
    var result = await canLaunch(url);
    if (result) {
      return await launch(url);
    } else {
      return Future.value(false);
    }
  }
}

abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus status, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

class RouteJumpListener {
  late OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
