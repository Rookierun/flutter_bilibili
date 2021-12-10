import 'package:flutter_bilibili/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  //支持查询参数，也应该支持path参数
  var pathParams;
  var useHttps = true;

  //服务器域名
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().contains("/")) {
        pathStr = "${path()}/$pathParams";
      } else {
        pathStr = "${path()}$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    if (needLogin()) {
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    print('uri:${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = {};

  //添加参数
  BaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  //header相关
  Map<String, dynamic> header = {
    'course-flag': 'fa',
    'auth-token': 'MjAyMc0wNi0yMyAwMzoyNTowMQ==fa'
  };
  BaseRequest addHeader(String key, Object value) {
    header[key] = value.toString();
    return this;
  }
}
